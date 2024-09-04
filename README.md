# Leumi Assignment

## Author of this task: Shay Guedj

## Important notes:

* Task 1: I stored my docker credentials on jenkins credentials, and I put a comment in the Jenkinsfile about it to let you know. 
  Also, I wrote where are the parameters to change like the kubeconfig file path, SSH key path (or can be stored in jenkins' credentials) to use on the second instance, the IP address of the second instance (can be set as a parameter in the pipeline if parameterized),
  and the user (also can be set as a parameter in the pipeline if parameterized).
  In addition, instead of providing the deployment and the service yaml files to the git repository, the Jenkinsfile will write them from the job to folder /tmp/ .
  When the job is done successfully, it will clean the workspace from it.

* Tasks 2-4: I wrote a Word file with the answers 2,3, and 4. I attached it to the email I sent.
  
* Task 5: I used a key pair named "test" in order to run the Terraform. Please use it or remove the key from the lines. 
  I updated the scripts to use the proxy IP as requested as well (part a and part b of the task are together in the modules folder).
