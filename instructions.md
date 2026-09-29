## Writing a post

Add a Markdown file to `_posts/` named `YYYY-MM-DD-some-slug.md`:

```markdown
---
layout: post
title: "Some Title"
image: /assets/images/some-cover.jpg   # optional, shown on the home page card
excerpt: "One or two lines for the home page."
minutes_to_read: 3                      # optional
---

Post body in Markdown.
```

It'll show up at `/post/some-slug/`.

## Local preview

```sh
bundle install
RUBYOPT=-r./tools/ruby4-compat.rb bundle exec jekyll serve
```

The `RUBYOPT` shim is only needed on Ruby 3.2+ (the Liquid version pinned by `github-pages` is older than that).
GitHub's build doesn't need it.

## Deploying

Served at **https://blog.thenihoniumfiles.com** (set by the `CNAME` file and `url` in `_config.yml`).

1. Push to `main`, then in the repo go to **Settings → Pages** and choose **Deploy from a branch → `main` / root**.
   The custom domain field should fill in from `CNAME`.
2. At your DNS provider, add a record: `CNAME  blog  →  sihal3.github.io`.
3. Once GitHub shows the DNS check passing, tick **Enforce HTTPS**.

Old Wix paths (`/post/<slug>`, `/about`, `/about-1`) work on the new subdomain, but links to
`www.thenihoniumfiles.com` won't reach it unless you forward that hostname to `blog.` at your DNS provider/registrar.
