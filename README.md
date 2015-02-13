# Dungeons and Dwarves
### Last update: 2/11/2015

# Table of Contents
* [Project Overview](#overview)
* [Github and Repo Management](#github-rules)

## <a name="overview"></a>Project Overview

## <a name="github-rules"></a>Github and Repo Management
This assumes you've installed and configured git on Windows.  See [this link](http://git-scm.com/book/en/v2/Getting-Started-Installing-Git#Installing-on-Windows) and follow the instructions for installing the Github for Windows client.
* [Creating Your Fork](#github-fork)
* [Pull Requests and Keeping Your Fork Up-to-Date](#github-pull)
* [Committing Changes](#github-commit)
* [Merging Local Changes](#github-merge)
* [Getting Your Changes Into the Main Repository](#github-contribute)

### <a name="github-fork"></a>Creating Your Fork
1. Go to the [Main Repository](https://github.com/MysteryPoo/SchoolPrototype)
2. Click the Fork button in the upper right hand corner of the page.
3. In the Github for Windows client, click the '+' icon, select Clone, and select your fork.
4. Select where you'd like to clone the repository locally.
  
### <a name="github-pull"></a>Pull Requests and Keeping Your Fork Up-to-Date
<p>If you're behind the master repository and need some of the changes, you can merge those changes into your fork with a pull request.</p>
1. Go to the Notification menu on your fork page and click "Pull Request"
2. Set the <b>base fork</b> as your fork and the <b>head fork</b> to the repository you are pulling commits from.
3. Set the Title to something meaningful to signify you were merging updates from the master repo.
4. Press merge pull requests.  Hopefully changes can be auto-merged, otherwise resolve conflicts as necessary.
5. In the Github for Windows client, click the 'Sync' button in the top right corner
  
### <a name="github-commit"></a>Committing Changes

1. Navigate to the branch you would like to commit changes to.
2. Select uncommitted changes section and show details.
3. Enter a summary and detailed description according to the development standards listed previously.
4. Click the "Commit to <branch-name>" button.
5. If you want to push your changes to your remote fork, click the Sync button.

### <a name="github-merge"></a>Merging Changes
<p>If you're working on a local development branch (the reccommended way to work) you'll eventually want to merge the changes from that branch into your master.</p>
1. In the Github for Windows client, select the branch drop-down in the top left corner.
2. Select "Manage" in the top right corner of the drop-down menu.
3. Drag the branch you would like to merge changes <b>from</b> to the first branch box along the bottom of the window.
4. Drag the branch you would like to merge changes <b>into</b> to the second branch box along the bottom of the window.
5. Click Merge.

### <a name="github-contribute"></a>Getting Your Changes Into the Main Repository
<p> Eventually you'll have some changes you'll want to push to the main repo. </p>
1. On the github website, navigate to your fork's top level and select "Pull Request"
2. Set the <b>base fork</b> as the main repository and the <b>head fork</b> to your fork.
3. Submit the Pull Request
4. Talk over the changes with Matt and make sure everything looks good, only he can finalize the pull.
