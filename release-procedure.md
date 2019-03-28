# how to update this repo at a release
 - update README as needed
 - run `bash check-for-updates.sh` to figure out what file are out of sync with the release branch
 - copy over files from the release branch as needed until check-for-updates.sh is happy
 - delete the `language-overview` directory
 - run `bash make-language-overview.sh`
 - commit/push all the changes
