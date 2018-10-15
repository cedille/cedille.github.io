Keep in mind that this repo is meant to simply "display" data from
other Cedille repos on the Cedille homepage. This means that most of
the files in this repo are helper scripts/resources for accomplishing
that task, OR they are files that are copied from other repos
(possibly done automatically by a script).

The only "canonical" information about Cedille that exists in this
repo is `README.md`.

Given this, you *probably* do not want to manually edit any of the
documentation that appears in this repo (with `README.md` being the
only exception). Generally, if you are committing to this REPO you are
committing changes to the helper scripts, or you are committing
changes to the website content that came from copying things from
either the cedille/cedille master/release-* branch. If you want to fix
some documentation you should probably go fix it in the
cedille/cedille master branch first, and then if the fix is relevant
to the current Cedille release, you should cherry pick that commit to
the release branch, and then copy the fix from the Cedille release
branch to this repo.
