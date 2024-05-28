This tutorial is the first in a [series of tutorials](#next-tutorials) that will guide you through the process of creating a cookbook and running it on TACC systems. From simple ones that run a command to more complex ones that run a Python using conda or a Jupyter Notebook.

## Requirements

- A GitHub account
- TACC account. If you don't have one, you can request one [here](https://accounts.tacc.utexas.edu/register)
- To access TACC systems, you should have an [allocation](https://tacc.utexas.edu/use-tacc/allocations/)
  - You can see your allocations [here](https://ptdatax.tacc.utexas.edu/workbench/allocations/approved)
  - If you don't have an allocation, you can request one [here](https://portal.tacc.utexas.edu/allocation-request)

## Tutorial

In this tutorial, we will create a simple Python script that will be used to demonstrate how to run a cookbook a TACC cluster and obtain the output using a UI. This cookbook will run a Python script that reads a CSV file, calculates the average of the values in the first column, and writes the result to a file.

The file will be storaged on the TACC storage system. In this case, the file is small however, you can use the same process to analyze large files.

### How does it work?

1. The [`app.json`](app.json) file contains the definition of the Tapis application, including the application's name, description, Docker image, input files and advanced options.
2. The Docker image defines the runtime environment for the application. Also, it includes `run.sh` file that contains the commands that will be executed by the Tapis job. A Docker Image is built from the [`Dockerfile` file](./Dockerfile).
3. The file [`run.sh`](run.sh) contains all the commands that will be executed on TACC cluster.

### 1. Upload the file to the TACC storage system

One of the goals of the tutorial is to demostrate how to use the TACC storage system to store the input and output files. So, you should upload the CSV file to the TACC storage system.

1. Go to the [TACC Portal](https://portal.tacc.utexas.edu)
2. Click on the "Data Files" tab
3. Click on the "Add +" button
   ![alt text](images/image.png)
4. Click on the "Upload" button
   ![alt text](images/image-1.png)
5. Select the file you want to upload

### 2. Understanding the Python script

The Python script reads a CSV file, calculates the average of the values in the first column, and writes the result to a file. It uses the Pandas library to read the CSV file.

### 3. Define dependencies using `environment.yaml`

As we know, the Python script uses Pandas to read the CSV file. So, we need to define the dependencies in the `environment.yaml` file.

Open the `environment.yaml` file and add the `pandas` packages. The content should be like this:

```yaml
name: base
channels:
  - conda-forge
dependencies:
  - python=3.9.1
  - pandas
```

### 4. Understading the `run.sh` file

The `run.sh` file is used to run the Python script. It runs the Python script.

```bash
#!/bin/bash
set -xe
cd ${_tapisExecSystemInputDir}
python /code/main.py billing.csv ${_tapisExecSystemOutputDir}/output.txt
```

The `run.sh` has two variables that are used to define the input and output directories. These variables are `_tapisExecSystemInputDir` and `_tapisExecSystemOutputDir` which are automatically set by the Tapis system.

- \_tapisExecSystemInputDir: The directory where the input files are staged
- \_tapisExecSystemOutputDir: The directory where the application writes the output files

### 5. Understanding the Dockerfile

`Dockerfile` is used to create a Docker image that will be used to run the Python script. The Docker image is created using the `microconda` base image, which is a minimal image that contains conda. The `environment.yaml` file is used to install the dependencies in the Docker image.

Since you modified the `environment.yaml` file, you should build the Docker image again. To build the Docker image, run the following command:

```bash
docker build -t cookbook-template-conda .
docker tag cookbook-python <your-docker-username>/cookbook-template-conda
docker push <your-docker-username>/cookbook-template-conda
```

### 5. Update the Cookbook Definition `app.json` File

Each app has a unique `id` and `description`. So, you should change these fields to match your app's name and description.

1. Download the `app.json` file
2. Change the values `id` and `description` fields with the name and description as you wish.
3. Change the `containerImage` field with the Docker image you created `your-docker-username/cookbook-template-conda`

### 6. Create a New Application on the Cookbook UI

1. Go to [Cookbook UI](https://in-for-disaster-analytics.github.io/cookbooks-ui/#/apps)
2. Click on the "Create Application" button
3. Fill in the form with the information from your `app.json` file
4. Click "Create Application"
5. A new application will be created, and you will be redirected to the application's page

### 7. Run Your Cookbook

1. Click on the "Run" button on the right side of the page. This will open the Portal UI
2. Click on the "Select" button to choose the input file
   ![alt text](images/image-2.png)
3. Click "Run"

### 8. Check the Output

1. After the job finishes, you can check the output by clicking on the "Output location" link on the job's page
   ![Show a job finished ](images/job-finished.png)
2. You will be redirected to the output location, where you can see the output files generated by the job
   ![alt text](images/image-4.png)
3. Click on a file to see its content. In this case, the file is named `output.txt`
   ![alt text](images/image-3.png)

## Next Tutorials

- [Running a Python script]
- [Running a Jupyter Notebook]

## Authors

William Mobley - wmobley@tacc.utexas.edu
Maximiliano Osorio
