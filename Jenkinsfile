// pipeline {
//     environment {
//         // This registry is important for removing the image after the tests
//         registry = "yourname/nodeapp"
//     }
    
//     agent any
    
//     stages {
//         stage("Test") {
//             steps {
//                 script {
//                     // Building the Docker image
//                     dockerImage = docker.build registry + ":$BUILD_NUMBER"
//                     try {
//                         dockerImage.inside() {
//                             // Extracting the PROJECTDIR environment variable from inside the container def
//                             PROJECTDIR = sh(script: 'echo \$PROJECTDIR', returnStdout: true).trim()
//                             // Copying the project into our workspace
//                             sh "cp -r '$PROJECTDIR' '$WORKSPACE'"
//                             // Running the tests inside the new directory
//                             dir("$WORKSPACE$PROJECTDIR") {
//                                 sh "npm test"\
//                             }
//                         }
//                     } finally {
//                         // Removing the docker image
//                         sh "docker rmi $registry:$BUILD_NUMBER"
//                     }
//                 }
//             }
//         }
//     }
// }

pipeline {
    environment {
        // This registry is important for removing the image after the tests
        registry = "9398320218/nodeapp"
    }

    agent any

    tools {nodejs "node"}

    stages {
        stage('SCM Checkout') {
            steps{
                git url:'https://github.com/saikumarkaleru/majorproject_2.git', branch:'master'
            }
        }        
        stage('Build Docker Images') {
            steps {
                sh 'chmod -R 777 ./docker.sh'
                sh './docker.sh'
            }   
        }
        stage('Testing') {
            steps {
                // script {
                //     // Building the Docker image
                //     dockerImage = docker.build registry + ":$BUILD_NUMBER"
                //     try {
                //         dockerImage.inside() {
                //             // Extracting the PROJECTDIR environment variable from inside the container def
                //             PROJECTDIR = sh(script: 'echo \$PROJECTDIR', returnStdout: true).trim()
                //             // Copying the project into our workspace
                //             sh "cp -r '$PROJECTDIR' '$WORKSPACE'"
                //             // Running the tests inside the new directory
                //             dir("$WORKSPACE$PROJECTDIR") {
                                sh 'chmod -R 777 ./jest.sh'
                                sh './jest.sh'
                //             }
                //         }
                //     } finally {
                //         // Removing the docker image
                //         sh "docker rmi $registry:$BUILD_NUMBER"
                //     }
                // }
            } 
        }
        stage('Deployment') {
            steps {
                sh 'chmod -R 777 ./kubernetes.sh'
                sh 'sudo -S su ubuntu -c "./kubernetes.sh" '
            }   
        }
    }
}