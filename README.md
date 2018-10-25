# Getting Started with Bamboo and CrossBrowserTesting

Bamboo is a CI server by Atlassian. It has a host of powerful tools that allow you and your team to automatically build and test software, track successful and failed builds, and even deploy passing code. Bamboo is fully compatible with CBT, so you can include our service in your CI process.

## Basic Setup
First, set up your Bamboo server as per [Atlassian's installation guide](https://confluence.atlassian.com/bamboo/bamboo-installation-guide-289276785.html). Make sure your JAVA_HOME environment variable is set correctly.
Once your server is set up, go to http://localhost:8085 (or specified port if you have changed it from the default value 8085). Since every organization has different guidelines and practices for CI processes, our example will be a simple plan-- a single stage that contains one job. If you'd like to set up a simple proof of concept, you can clone this repository, link it to your plan, and copy our setup.

#### Plan Settings

After [linking your repository](https://confluence.atlassian.com/bamboo/linking-to-source-code-repositories-671089223.html), set up your plan with the following stages, jobs, and tasks (the contents of the script steps are included in the root of this repository):
```
Default Stage
	Job: Run tests
		Tasks:
		-Source code checkout
		-Script (Start Local Connection) 
		-Maven build
			-Executable: mvn (use your MAVEN_HOME path when it asks for the path)
			-Goal: clean test
			-Build JDK: Should auto-populate, if not, add it in with the path for the desired JDK
			-Don't use the environment variables field in this task for test capabilities/username/authkey--place them in the plan environment variables
		-Script (Close Local Connection) *Drag this one down to the final tasks area so that it will close the local connection even if the rest of the build fails
```

#### Environment Variables

If you would like to use environment variables for your username and authkey, set them in the "variables" tab of your plan configuration menu. You can then access them inside your scripts the same way you would access a system environment variable, using the name bamboo_VARIABLE_NAME. So if you were to set a variable named CBT_USERNAME in Bamboo, you could access it in Java code in that build with "System.getenv("bamboo_CBT_USERNAME")". If you need to access them in a script step or shell, it would be $bamboo_CBT_USERNAME.

#### Local Connection

When opening a local connection with Bamboo, special care must be taken to ensure that it runs in the background (Bamboo will not move on to the next task otherwise) and that the local connection will be closed even in the event that part of the build fails. In order to run the connection in the background, place `nohup` before the command (this makes it so that it doesn't send anything to the console) and place `> /dev/null 2>&1 &` after it. That runs the command in the background and stops Bamboo from waiting on that process.

To ensure that the connection is closed even after a build failure, drag the script to close the connection into the area labelled "final tasks."

## Important Notes

Environment variables and commands can be affected by the machine they are running on. Make sure that the commands and steps are compatible with the machine you're running the Bamboo server on. You can also take advantage of this by keeping a copy of cbt_tunnels on that machine so you don't have to download it every time. Bamboo is extremely powerful and flexible, so there is more than one "right" way to do most tasks.

If you need any help getting set up, don't hesistate to reach out to out support team!
