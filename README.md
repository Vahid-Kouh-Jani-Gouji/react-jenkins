# Getting Started containerised React APP with CI/CD with Jenkins in AWS-EC2 and Terraform

first step : terraform init 
second step : terraform applay

## Available Jenkins password :

- **an EC2 Instance**: create new folder and `docker-compose` file:

```bash
sudo mkdir -p /var/jenkins_home
mkdir $HOME/jenkins
vim $HOME/jenkins/docker-compose.yml
```

```yaml
version: '3'
services:
  jenkins:
    image: jenkins/jenkins:lts
    restart: always
    privileged: true
    user: root
    ports:
      - 8080:8080
      - 50000:50000
    container_name: jenkins
    volumes:
      - /var/jenkins_home:/var/jenkins_home
      - /usr/bin/docker:/usr/bin/docker
      - /var/run/docker.sock:/var/run/docker.sock
```

- Still on the EC2 instance and in the `$HOME/jenkins` folder, start the container

```bash
sudo docker compose up
```

- notic: Password:

```
jenkins  | Jenkins initial setup is required. An admin user has been created and a password generated.
jenkins  | Please use the following password to proceed to installation:
jenkins  |
jenkins  | 0d63c16741c445839c0182dc29e0efee
```

### 2.2 Create the Jenkins Pipeline

- In the Jenkins frontend click on `Create a Job`
- Name your job `ReactApp` **NO SPACES IN JOB NAME**
- Select the `Pipeline` configuration
- Select the item `Github Project` and enter the URL to your fork
- Click on `Poll SCM` and enter the following schedule: `H/5 * * * *` (Every 5 minutes) -> Jenkins checks every 5 minutes whether your code has changed and starts a new pipeline
- Under the Pipeline section, select `Pipeline script from SCM` to use a pipeline script from the repo
- Select `Git` under SCM and enter the URL to your fork again (must end with .git)
- Click on 'Save'

### 2.3 First test job

- In the menu of the `React App` job, click on `Build now`
- Look at the log and make sure all steps are completed
     - At the bottom right click on Build Id (`#1`)
     - Click on `Console Output`
