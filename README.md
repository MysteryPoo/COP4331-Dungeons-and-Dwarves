# Dungeons and Dwarves
### Last Readme update: 2/13/2015

# Table of Contents
* [Project Overview](#overview)
* [Promoting Changes and Commit Messages](#promotion)
* [Github and Repo Management](#github-rules)

## <a name="overview"></a>Project Overview
Project repository for the Spring 2015 final project in COP4331.  A multiplayer dungeon crawling game for desktops and Android devices.  If you've arrived at a fork, the main repository can be found [here](https://github.com/MysteryPoo/SchoolPrototype).

## <a name="promotion"></a>Promoting Changes and Commit Messages
<p> When commiting changes, format your commit message as follows: </p>
* The title of the commit should have one of the following labels, followed by the name of the file modified:
  - Feature
     * Adding a new feature (level, GUI, etc)
  - Bug Fix
     * Adding a solution to a bug in the code
  - Trivial
     * Quality-of-Life changes (changing code to meet develpoment standards for example)
  - Enhancement
     * Enhancing a current feature with improved functionality
  - Code Removal
     * Ideally rare.  Removing whole files or large sections of code.  Please discuss with team and particularly Matt first.

* The description in the commit message should contain a detailed explanation of what was changed.  Anyone should be able to clearly know what your changes are by reading the description.

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
1. In the Github for Windows client, navigate to the local repository you'd like to apply changes to.
2. In the Uncommitted Changes section, select the file(s) you would like to update from the right hand window.  For each file, click the arrow to expand the diff view.  You should see the file contents with red removals and green additions to the file.
3. The two leftmost columns in the diff view shows comparison of the line numbers in the two versions of the file.  The left column is the line number in the current most recent commit, the right column is the line number in the uncommitted version of the file with your changes.
4. Select the changes you would like to commit.  Clicking one of the leftmost columns with the line numbers will select an individual line.  Clicking to the right of this, on the '+' or '-' characters, will select an entire block.  The lines that will be selected are highlighted before you click.
5. Enter your commit message according to the standards described above.
6. Double (triple) check your selections for each file.
7. Click the "Commit to branch-name" icon.
8. Click the "Sync" button in the top right corner if you'd like to push your changes to your remote repository.

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
