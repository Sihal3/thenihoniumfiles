# The Liquid version pinned by github-pages calls Object#tainted?, which was removed in Ruby 3.2.
# Only needed for local previews; GitHub's own build doesn't use this file.
class Object
  def tainted?; false; end
  def taint; self; end
  def untaint; self; end
end
