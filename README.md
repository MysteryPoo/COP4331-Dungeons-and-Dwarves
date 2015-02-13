# Dungeons and Dwarves
### Last update: 2/11/2015

# Table of Contents
* [Project Overview](#overview)
* [Github and Repo Management](#github-rules)

## <a name="overview"></a>Project Overview

## <a name="github-rules"></a>Github and Repo Management
This assumes you've installed and configured git on Windows.  See [this link](http://git-scm.com/book/en/v2/Getting-Started-Installing-Git#Installing-on-Windows) and follow one of the options there.  <b>Make sure you add the git binaries to your PATH Environment Variable if you intend to use the command line without the git shell.</b>
* [Creating Your Fork](#github-fork)
* [Pull Requests and Keeping Your Fork Up-to-Date](#github-pull)
* [Committing Changes](#github-commit)
* [Merging Local Changes](#github-merge)
* [Getting Your Changes Into the Main Repository](#github-contribute)

### <a name="github-fork"></a>Creating Your Fork
1. Go to the [Main Repository](https://github.com/MysteryPoo/SchoolPrototype)
2. Click the Fork button in the upper right hand corner of the page.
3. On your new fork's main page, click the copy to clipboard icon on the right side of the page.
4. On your machine, open up a console window (Command Prompt or Powershell)
5. Navigate to the directory you want to download the project files in.
6. Get a local copy of your fork
  1. In the console window type: `git clone ` and paste the link to your fork.  Run the command. <b> OR </b>
  2. In the Github for Windows client, click the '+' icon, select Clone, and select your fork.
  
### <a name="github-pull"></a>Pull Requests and Keeping Your Fork Up-to-Date
<p>If you're behind the master repository and need some of the changes, you can merge those changes into your fork with a pull request.</p>
1. Go to the Notification menu on your fork page and click "Pull Request"
2. Set the <b>base fork</b> as your fork and the <b>head fork</b> to the repository you are pulling commits from.
3. Set the Title to something meaningful to signify you were merging updates from the master repo.
4. Press merge pull requests.  Hopefully changes can be auto-merged, otherwise resolve conflicts as necessary.
5. Update your local copy
  1. Navigate to your local copy in a terminal window (Command Prompt/Powershell/git shell) and enter `git pull`
  2. In the Github for Windows client, click the 'Sync' button in the top right corner
  
### <a name="github-commit"></a>Committing Changes
1. Navigate to your project folder in a terminal window.
2. If you want to stage all changes for a commit, enter `git add .`
3. If you want to stage individual files, enter `git add \path\to\file`
4. In the terminal window enter `git commit -m "<commit-message>"` where <commit-message> is replaced with a short message describing the purpose of the commit.
5. If you want to push your changes to your remote fork, enter `git push origin`

### <a name="github-merge"></a>Merging Changes
<p>If you're working on a local development branch (the reccommended way to work) you'll eventually want to merge the changes from that branch into your master.</p>
1. In a terminal window navigate to your project directory.
2. Checkout the master branch with `git checkout master`
3. Merge the changes from your branch using `git merge <branch-name>` where <branch-name> is replaced with the branch with changes you want to merge into master.

### <a name="github-contribute"></a>Getting Your Changes Into the Main Repository
<p> Eventually you'll have some changes you'll want to push to the main repo. </p>
1. On the github website, navigate to your fork's top level and select "Pull Request"
2. Set the <b>base fork</b> as the main repository and the <b>head fork</b> to your fork.
3. Submit the Pull Request
4. Talk over the changes with Matt and make sure everything looks good, only he can finalize the pull.
