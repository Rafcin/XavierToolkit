# Installing ROS
Tutorial for installing the ROS workspace.
## Installing ROS Melodic
##### 1. Setup your sources.list
```
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
```
##### 2. Set up your keys
```
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
```
##### 3. Installation
```
sudo apt-get update
```
##### 4. Desktop-Full Install
Install the full desktop version of ROS Melodic, this will install all the tools you need.
```
sudo apt-get install ros-melodic-desktop-full
```
### Installing Sphinx
Add the repo so you can install sphinx.
```
sudo add-apt-repository ppa:builds/sphinxsearch-stable
sudo apt-get update
```
Install Sphinx
```
sudo apt-get install sphinxsearch
```
## Creating a ROS workspace
##### Building
A script has been added to easily build a local host workspace for ROS in the home directory.
Run the following script and do note that you need to give permissions to the .sh file to execute.
```
chmod 755 *.sh // Run this command inside the current directory you are in and it will give all the .sh files in it permission to run.
./create_ros_workspace.sh //Builds the workspace yokai_ws in the home directory.
```
Now enter the directory and source the project so you can run the correct commands to test it.
```
cd yokai_ws // Go to directory
source /opt/ros/melodic/setup.bash // You have to run source every time you open a new terminal or add new resources into source.
```
Note that if you add new packages to yokai_ws/src, you need to rebuild the project. To test if the project builds and to build the project, you can run the command;
```
catkin_make
````
When you look for packages to later install, note that the ROS wiki is the best place to look, almost all packages have documentation and they all come with github links you can clone.

For more informatin look here to see how ROS works and how you can use it.
http://wiki.ros.org/ROS/Tutorials

If you want to see the set paths you have exported for ROS run:
```
env | grep ROS
```

## Errors and Bugs
If you run into problems such as certain modules missing, you may either have to sudo ap-get install {pkg name} each one or if that fails to work, use pip install {pkg name}. Pip comes from Python, you should have Python 3.6 and 2.7 installed, 3.6 is the one we will be using so keep that in mind. Also do note running pip will run it under 3.6 while running pip2 will run it under 2.7.
An example of using pip to install something is sphinx, if sphinx wont run after being installed with apt, install it with pip.