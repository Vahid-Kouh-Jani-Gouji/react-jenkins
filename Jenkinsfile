node {
  stage('Checkout') {
    git branch: 'master', url: 'https://github.com/0xfabio/jenkins-react-app.git'
  }
  stage('Build') {
   
    sh 'docker ps --filter name=node | grep node && docker kill node || true'
    sh 'docker run -d --rm --name node -v ${WORKSPACE}:/var/app -w /var/app node:lts-bullseye tail -f /dev/null'
    sh 'docker exec node npm --version'
    sh 'docker exec node ls -la'
    sh 'docker exec node npm ci'
    sh 'echo "test for CI!"'
    sh 'docker exec node npm run build'

    // Create Dockerfile with the desired content
    writeFile file: 'Dockerfile', text: 'FROM nginx:latest\nCOPY ./build /usr/share/nginx/html'

    // Build the Docker image
    sh 'docker build -t test .'

    // Run the Docker container
    sh 'docker run -d -p 80:80 test:latest'
    
     // sh 'docker kill node'
  }
  // stage('Cleanup') {
  //   deleteDir()
  // }
}

