---
layout: post
title: "MIT BattleCode 2021"
date: 2021-03-10 20:29:01 -0800
image: /assets/images/mit-battlecode-2021-1.png
excerpt: "This year, in January, I participated in MIT's BattleCode Competition. The competition, as the name suggests, is based in coding. Each..."
minutes_to_read: 8
---

![]({{ "/assets/images/mit-battlecode-2021-1.png" | relative_url }})

This year, in January, I participated in MIT's BattleCode Competition.

The competition, as the name suggests, is based in coding. Each year MIT students make a new, 2D, Java game. Participants then write their own code to control one side and face off against other people's code.

The rules are rather complicated, but I'll try to explain a simplified version. This year, fittingly, the game was designed with an election in mind. There are four types of units that each side has, with various abilities. The Muckraker, the Politician, and the Slanderer are mobile troops. They can move once every two turns and have various actions like earning influence (the currency of the game) or killing enemy troops. The Enlightenment Centers are fixed and can make the other kinds of troops.

Each troop ran a copy of my or the other team's Java code, which told it where to go and what to do.

The competition started early January and I had essentially one month to write my program, with various tournaments along the way. Unfortunately, the seniors in my Comp Sci class all had college applications to do, and I was left as a solo team.

So began a back and forth of iteration and improvement. At first, I had no clue how I was supposed to code in a cohesive strategy that covered attack, defense, and everything in between. It seemed like everything would have to be intensely complicated.

I eventually got some inspiration through the BattleCode Discord. I saw teams comparing their bot results in scrimmages against other teams, and I watched a couple of those matches. Instantly, the strategy became clear. I was far overcomplicating it. Instead of encoding complex strategies, I just had to encode a couple of simple behaviors that together would comprise a viable strategy

I had a one-man coding marathon over the weekend with all of my pent-up thinking. Each troop just had a simple hierarchy of commands: A Slanderer, for example, being the money-making troop, had priority 1 as moving away from enemies, priority 2 as staying near friendly troops, and priority 3 to simply move randomly.

I was rushing and rushing to code all of this, even during my Zoom classes, to get it in before the first Sprint Tournament deadline. I missed the deadline by 30 minutes.

After that, it was just a test and improve game. Whenever I had an idea for how to improve it, I made the changes and tried them out. Adding rush capability to group and attack enemy centers, beefing up defense, improving slanderer economy, so on. My bot became incrementally better.

End in end, I turned out with a pretty solid bot. Nothing award-winning, 17th place in the high-school tournament, but I loved my design and I had done it all myself.

Here's the code of the final version if you want a look for yourself:

{% raw %}
```java
package cavShieldv7;

import battlecode.common.*;

import java.util.ArrayList;

public strictfp class RobotPlayer {
    static RobotController rc;

    static final RobotType[] spawnableRobot = {
            RobotType.POLITICIAN,
            RobotType.SLANDERER,
            RobotType.MUCKRAKER,
    };

    static final Direction[] directions = {
            Direction.NORTHWEST,
            Direction.NORTH,
            Direction.NORTHEAST,
            Direction.EAST,
            Direction.SOUTHEAST,
            Direction.SOUTH,
            Direction.SOUTHWEST,
            Direction.WEST,
    };
    static final int[] slanderer = {
            21, 41, 63, 85, 107, 130, 154, 178, 203, 228, 256, 282,
            310, 339, 368, 399, 431, 463, 497, 532, 568, 605, 643,
            683, 724, 766, 810, 855, 902, 949
    };

    static int turnCount;
    static int purpose = -1;
    static int ecid = -1;
    static MapLocation ecloc;
    static MapLocation target;
    static ArrayList<Integer> muckIDs = new ArrayList<Integer>();
    static ArrayList<Integer> targets = new ArrayList<Integer>();
    static boolean buffpols;
    static int buffpolcount;
    /**
     * run() is the method that is called when a robot is instantiated in the Battlecode world.
     * If this method returns, the robot dies!
     **/
    @SuppressWarnings("unused")
    public static void run(RobotController rc) throws GameActionException {

        // This is the RobotController object. You use it to perform actions from this robot,
        // and to get information on its current status.
        cavShieldv7.RobotPlayer.rc = rc;
        if(rc.canSetFlag(0)) {
            rc.setFlag(0);
        }
        turnCount = 0;
        System.out.println("I'm a " + rc.getType() + " and I just got created!");
        while (true) {
            turnCount += 1;
            // Try/catch blocks stop unhandled exceptions, which cause your robot to freeze
            try {
                // Here, we've separated the controls into a different method for each RobotType.
                // You may rewrite this into your own control structure if you wish.
                System.out.println("I'm a " + rc.getType() + "! Location " + rc.getLocation());
                switch (rc.getType()) {
                    case ENLIGHTENMENT_CENTER: runEnlightenmentCenter(); break;
                    case POLITICIAN:           runPolitician();          break;
                    case SLANDERER:            runSlanderer();           break;
                    case MUCKRAKER:            runMuckraker();           break;
                }

                // Clock.yield() makes the robot wait until the next turn, then it will perform this loop again
                Clock.yield();

            } catch (Exception e) {
                System.out.println(rc.getType() + " Exception");
                e.printStackTrace();
            }
        }
    }

    static void runEnlightenmentCenter() throws GameActionException {
        if(purpose == -1) {
            purpose = 0;
        }
        int influence = rc.getInfluence();
        if(rc.isReady()) {
            RobotInfo[] robots = rc.senseNearbyRobots(-1, rc.getTeam().opponent());
            if(buffpols){
                spawn(0, (int) (influence * 0.5));
                buffpolcount--;
                if(buffpolcount == 0){
                    buffpols = false;
                }
            }
            if (robots.length != 0) {
                spawn(0, 49);
            }
            if(turnCount%4==0) {
                int r = (int)(Math.random() * 5);
                if(r==0) {
                    spawn(0, (int) Math.min(30, influence*0.2));
                } else {
                    int scount = 0;
                    for (RobotInfo robot : rc.senseNearbyRobots(-1, rc.getTeam())) {
                        if (robot.type.canBeExposed()) {
                            scount++;
                        }
                    }
                    if(scount < 35) {
                        int sinf = 0;
                        for(int i : slanderer) {
                            if (influence > i) {
                                sinf = i;
                            }
                        }
                        if(sinf==0) {
                        } else {
                            spawn(1, sinf);
                        }
                    } else {
                        spawn(0, 49);
                    }
                }
            } else if(turnCount%4==2) {
                spawn(2, 1);
                for (RobotInfo robot : rc.senseNearbyRobots(-1, rc.getTeam())) {
                    if (robot.type == spawnableRobot[2]) {
                        if(!muckIDs.contains(robot.ID)) {
                            muckIDs.add(robot.ID);
                        }
                    }
                }
            } else {
                for(int i = 0; i < muckIDs.size(); i++) {
                    if(rc.canGetFlag(muckIDs.get(i))) {
                        int flag = rc.getFlag(muckIDs.get(i));
                        if(flag != 0) {
                            boolean a = targets.contains(flag);
                            if(!a) {
                                for(int f : targets){
                                    if(getLocationFromFlag(f).equals(getLocationFromFlag(flag))){
                                        targets.remove((Integer)f);
                                        //maybe break?
                                    }
                                }
                                if(getExtraFromFlag(flag) == 2) {
                                    targets.add(0, flag);
                                    buffpols=true;
                                    buffpolcount = 1;
                                } else if(getExtraFromFlag(flag) == 1) {
                                } else {
                                    targets.add(flag);
                                    buffpols=true;
                                    buffpolcount = 1;
                                }
                            }
                        }
                    } else {
                        muckIDs.remove(i);
                    }
                }
            }
        }
        if(rc.getTeamVotes() < 751) {
            if(rc.getTeamVotes()/rc.getRoundNum()<0.4) {
                if (rc.canBid((int)(0.1*influence))) {
                    rc.bid((int)(0.1*influence));
                    System.out.println("Bid " + (int)(0.1*influence));
                }
            } else {
                if (rc.canBid((int)(0.05*influence))) {
                    rc.bid((int)(0.05*influence));
                    System.out.println("Bid " + (int)(0.05*influence));
                }
            }
        }
        if(targets.size() != 0) {
            if(rc.canSetFlag(targets.get(0))){
                rc.setFlag(targets.get(0));
            }
        } else {
            if(rc.canSetFlag(0)){
                rc.setFlag(0);
            }
        }
    }

    static void runPolitician() throws GameActionException {
        if (ecid == -1) {
            for (RobotInfo robot : rc.senseNearbyRobots(-1, rc.getTeam())) {
                if (robot.type == RobotType.ENLIGHTENMENT_CENTER) {
                    ecid = robot.ID;
                    ecloc = robot.location;
                }
            }
        }
        MapLocation loc = rc.getLocation();
        Team enemy = rc.getTeam().opponent();
        int actionRadius = rc.getType().actionRadiusSquared;
        RobotInfo[] robots = rc.senseNearbyRobots();
        if(!rc.isReady()) {
            return;
        }

        if(rc.getInfluence() > 350) {
            if (rc.canGetFlag(ecid)) {
                if (rc.getFlag(ecid) != 0) {
                    if (getExtraFromFlag(rc.getFlag(ecid)) != 1) {
                        target = getLocationFromFlag(rc.getFlag(ecid));
                    }
                } else {
                    target = null;
                }
            }
            for (RobotInfo robot : robots) {
                if (robot.type == RobotType.ENLIGHTENMENT_CENTER && !(robot.team.equals(rc.getTeam()))) {
                    if (robot.location.isWithinDistanceSquared(loc, 1) && rc.canEmpower(1)) {
                        rc.empower(1);
                        return;
                    } else {
                        tryMove(loc.directionTo(robot.location));
                        return;
                    }
                } else if (robot.type == RobotType.ENLIGHTENMENT_CENTER && (robot.team.equals(rc.getTeam()))) {
                    if (robot.location.isWithinDistanceSquared(loc, 1)) {
                        tryMove(loc.directionTo(robot.location).opposite());
                        return;
                    }
                }
            }
            if (target != null) {
                tryMove(loc.directionTo(target));
            }
            if (tryMove(randomDirection()))
                System.out.println("I moved!");
        } else if(rc.getInfluence() > 50) {
            if (rc.canGetFlag(ecid)) {
                if (rc.getFlag(ecid) != 0 ) {
                    if(getExtraFromFlag(rc.getFlag(ecid)) != 1) {
                        target = getLocationFromFlag(rc.getFlag(ecid));
                    }
                } else {
                    target = null;
                }
            }

            for (RobotInfo robot : robots) {
                if (robot.type == RobotType.ENLIGHTENMENT_CENTER && !(robot.team.equals(rc.getTeam()))) {
                    if (robot.location.isWithinDistanceSquared(loc, 1) && rc.canEmpower(1)) {
                        rc.empower(1);
                        return;
                    } else {
                        tryMove(loc.directionTo(robot.location));
                        return;
                    }
                } else if(robot.type == RobotType.ENLIGHTENMENT_CENTER && (robot.team.equals(rc.getTeam()))){
                    if(robot.location.isWithinDistanceSquared(loc, 1)){
                        tryMove(loc.directionTo(robot.location).opposite());
                        return;
                    }
                }
            }
            robots = rc.senseNearbyRobots(loc, -1, enemy);
            int counter = 0;
            for (RobotInfo robot : robots) {
                if (robot.location.isWithinDistanceSquared(loc, actionRadius)) {
                    counter++;
                }
                if(counter > 20) {
                    if(rc.canEmpower(actionRadius)) {
                        rc.empower(actionRadius);
                        return;
                    }
                }
                if(robot.type != spawnableRobot[2] && counter > 5){
                    if(rc.canEmpower(actionRadius)) {
                        rc.empower(actionRadius);
                        return;
                    }
                }

            }
            if (target != null) {
                tryMove(loc.directionTo(target));
            }
            if (tryMove(randomDirection()))
                System.out.println("I moved!");
        } else {
            robots = rc.senseNearbyRobots(-1, rc.getTeam());
            for (RobotInfo robot : robots) {
                if (robot.type == RobotType.ENLIGHTENMENT_CENTER && (robot.team.equals(rc.getTeam()))) {
                    if (robot.location.isWithinDistanceSquared(loc, 1)) {
                        tryMove(loc.directionTo(robot.location).opposite());
                        return;
                    }
                }
            }
            robots = rc.senseNearbyRobots(loc, -1, enemy);
            for(RobotInfo robot : robots) {
                if(robot.type == spawnableRobot[2]) {
                    if(robot.location.isWithinDistanceSquared(loc, actionRadius) && rc.canEmpower(actionRadius)) {
                        if((rc.getInfluence()-10)*rc.getEmpowerFactor(rc.getTeam(), 0)/rc.senseNearbyRobots(actionRadius).length >= 2) {
                            rc.empower(actionRadius);
                            return;
                        } else {
                            if(robot.location.isWithinDistanceSquared(loc, 1) && rc.canEmpower(1)){
                                if((rc.getInfluence()-10)*rc.getEmpowerFactor(rc.getTeam(), 0)/rc.senseNearbyRobots(1).length >= 2) {
                                    rc.empower(1);
                                    return;
                                }
                            }
                        }
                    }
                    tryMove(loc.directionTo(robot.location));
                    return;

                }
            }
            for(RobotInfo robot : robots) {
                if(robot.type == spawnableRobot[0]) {
                    if(robot.location.isWithinDistanceSquared(loc, actionRadius) && rc.canEmpower(actionRadius)) {
                        rc.empower(actionRadius);
                        return;
                    }
                }
            }
            if(rc.getLocation().isWithinDistanceSquared(ecloc, 40)) {
                tryMove(loc.directionTo(ecloc).opposite());
                return;
            }
            if(purpose == -1){
                purpose = (int) (Math.random()*2);
            }
            if(!rc.onTheMap(loc.add(loc.directionTo(ecloc).rotateLeft().rotateLeft()))){
                purpose = 1;
            } else if (!rc.onTheMap(loc.add(loc.directionTo(ecloc).rotateRight().rotateRight()))){
                purpose = 0;
            }
            if(purpose == 0) {
                tryMove(loc.directionTo(ecloc).rotateLeft().rotateLeft());
            } else if(purpose == 1) {
                tryMove(loc.directionTo(ecloc).rotateRight().rotateRight());
            } else {
                tryMove(randomDirection());
            }
        }
    }

    static void runSlanderer() throws GameActionException {
        if (ecid == -1) {
            for (RobotInfo robot : rc.senseNearbyRobots(-1, rc.getTeam())) {
                if (robot.type == RobotType.ENLIGHTENMENT_CENTER) {
                    ecid = robot.ID;
                    ecloc = robot.location;
                }
            }
        }
        if(!rc.isReady()) {
            return;
        }
        MapLocation loc = rc.getLocation();
        Team enemy = rc.getTeam().opponent();
        RobotInfo[] robots = rc.senseNearbyRobots(loc, -1, enemy);
        for(RobotInfo robot : robots) {
            if(robot.type == spawnableRobot[2]) {
                tryMove(loc.directionTo(robot.location).opposite());
                return;
            }
        }
        if(!rc.getLocation().isWithinDistanceSquared(ecloc, 25)) {
            tryMove(loc.directionTo(ecloc));
            return;
        }
        tryMove(randomDirection());
        return;

    }

    static void runMuckraker() throws GameActionException {
        if (purpose == -1){
            purpose = (int)(Math.random()*2);
        }
        if (ecid == -1) {
            for (RobotInfo robot : rc.senseNearbyRobots(-1, rc.getTeam())) {
                if (robot.type == RobotType.ENLIGHTENMENT_CENTER) {
                    ecid = robot.ID;
                    ecloc = robot.location;
                }
            }
        }
        if(rc.canGetFlag(ecid)) {
            if(rc.getFlag(ecid) != 0) {
                if(getExtraFromFlag(rc.getFlag(ecid)) == 2 ) {
                    target = getLocationFromFlag(rc.getFlag(ecid));
                }
            } else {
                target = null;
            }
        }
        for (RobotInfo robot : rc.senseNearbyRobots()) {
            if (robot.type == RobotType.ENLIGHTENMENT_CENTER && robot.location != ecloc) {
                if(robot.team.equals(rc.getTeam())){
                    sendLocation(robot.location, 1);
                    if (robot.location.isWithinDistanceSquared(rc.getLocation(), 1)) {
                        tryMove(rc.getLocation().directionTo(robot.location).opposite());
                        return;
                    }
                } else if (robot.team.equals(rc.getTeam().opponent())){
                    sendLocation(robot.location, 2);
                } else if (robot.team.equals(Team.NEUTRAL)){
                    sendLocation(robot.location, 3);
                } else {
                    sendLocation(robot.location, 0);
                }
            }
        }
        if(!rc.isReady()) {
            return;
        }
        Team enemy = rc.getTeam().opponent();
        int actionRadius = rc.getType().actionRadiusSquared;
        MapLocation loc = rc.getLocation();
        RobotInfo[] robots = rc.senseNearbyRobots(loc, -1, enemy);
        for(RobotInfo robot : robots) {
            if (robot.type.canBeExposed()) {
                if (rc.canExpose(robot.location)) {
                    System.out.println("e x p o s e d");
                    rc.expose(robot.location);
                    return;
                } else {
                    tryMove(loc.directionTo(robot.location));
                    return;
                }
            }
        }
        robots = rc.senseNearbyRobots(loc, -1, rc.getTeam());
        MapLocation closest = new MapLocation(0,0);
        for(RobotInfo robot : robots) {
            if(robot.type == spawnableRobot[2]){
                if(loc.distanceSquaredTo(closest) > loc.distanceSquaredTo(robot.location)){
                    closest = robot.location;
                }
            }
        }
        if(closest != new MapLocation(0,0) && closest.isWithinDistanceSquared(loc, 1)) {
            tryMove(rc.getLocation().directionTo(closest).opposite());
            return;
        }
        if (target != null) {
            tryMove(rc.getLocation().directionTo(target));
            return;
        }

        if(closest != new MapLocation(0,0)) {
            tryMove(rc.getLocation().directionTo(closest).opposite());
            return;
        }
        tryMove(randomDirection());
        return;
    }
    static void spawn(int type, int influence) throws GameActionException {
        if(type == 0 && influence < 11) {
            return;
        }
        for (Direction dir : directions) {
            if (rc.canBuildRobot(spawnableRobot[type], dir, influence)) {
                rc.buildRobot(spawnableRobot[type], dir, influence);
                return;
            }
        }

    }
    /**
     * Returns a random Direction.
     *
     * @return a random Direction
     * @throws GameActionException
     */
    static Direction randomDirection() throws GameActionException {
        return directions[(int) (Math.random() * 8)];
    }

    /**
     * Returns a random spawnable RobotType
     *
     * @return a random RobotType
     */
    static RobotType randomSpawnableRobotType() {
        return spawnableRobot[(int) (Math.random() * spawnableRobot.length)];
    }

    /**
     * Attempts to move in a given direction.
     *
     * @param dir The intended direction of movement
     * @return true if a move was performed
     * @throws GameActionException
     */
    static boolean tryMove(Direction dir) throws GameActionException {
        if (hmove(dir)) {
            return true;
        } else {
            int one = (int) (Math.random()*2);
            if(one == 1) {
                if (hmove(dir.rotateLeft()))  return true;
                else if (hmove(dir.rotateRight())) return true;
                else if (hmove(randomDirection())) return true;
            }
            if(one == 0) {
                if (hmove(dir.rotateRight()))  return true;
                else if (hmove(dir.rotateLeft())) return true;
                else if (hmove(randomDirection())) return true;
            }
        }
        return false;
    }
    static boolean hmove(Direction dir) throws GameActionException {
        if (rc.canMove(dir)) {
            rc.move(dir);
            return true;
        }
        return false;
    }
    public static int NBITS = 7;
    public static int BITMASK = (1 << NBITS) - 1;
    static void sendLocation(MapLocation location, int extraInformation) throws GameActionException {
        int x = location.x, y = location.y;
        int encodedLocation = (extraInformation << (2*NBITS)) + ((x & BITMASK) << NBITS) + (y & BITMASK);
        if (rc.canSetFlag(encodedLocation)) {
            rc.setFlag(encodedLocation);
        }
        System.out.println(encodedLocation);
    }

    static MapLocation getLocationFromFlag(int flag) {
        int y = flag & BITMASK;
        int x = (flag >> NBITS) & BITMASK;
        // int extraInformation = flag >> (2*NBITS);

        MapLocation currentLocation = rc.getLocation();
        int offsetX128 = currentLocation.x >> NBITS;
        int offsetY128 = currentLocation.y >> NBITS;
        MapLocation actualLocation = new MapLocation((offsetX128 << NBITS) + x, (offsetY128 << NBITS) + y);

        // You can probably code this in a neater way, but it works
        MapLocation alternative = actualLocation.translate(-(1 << NBITS), 0);
        if (rc.getLocation().distanceSquaredTo(alternative) < rc.getLocation().distanceSquaredTo(actualLocation)) {
            actualLocation = alternative;
        }
        alternative = actualLocation.translate(1 << NBITS, 0);
        if (rc.getLocation().distanceSquaredTo(alternative) < rc.getLocation().distanceSquaredTo(actualLocation)) {
            actualLocation = alternative;
        }
        alternative = actualLocation.translate(0, -(1 << NBITS));
        if (rc.getLocation().distanceSquaredTo(alternative) < rc.getLocation().distanceSquaredTo(actualLocation)) {
            actualLocation = alternative;
        }
        alternative = actualLocation.translate(0, 1 << NBITS);
        if (rc.getLocation().distanceSquaredTo(alternative) < rc.getLocation().distanceSquaredTo(actualLocation)) {
            actualLocation = alternative;
        }
        return actualLocation;
    }
    static int getExtraFromFlag(int flag){
        int BITMASK = 3 << (2 * NBITS);
        int extry = (flag & BITMASK) >>> (2*NBITS);
        System.out.println(extry);
        return extry;
    }

}
```
{% endraw %}
