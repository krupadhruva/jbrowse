# Basic instructions

* Requires Orbstack (or Docker) to run jbrowse2
* Type `make run`  and follow instructions

### Installation

#### Basic requirements

1. Python 3
2. Docker
3. curl

#### Orbstack for running and managing Linux containers on your computer

* Go to https://orbstack.dev/ and follow instructions to download and install on your computer (desktop/laptop)

  * MacOS specific: Install `docker` CLI from `homebrew` by running `brew install docker`

* Install `curl` (MacOS bundles it, no installation necessary)

* Open your system terminal (command shell) and type `docker --version`. If you do not see any errors, you are ready to run `jbrowse2` bundled in a container

* Python 3 should be part of MacOS and common Linux distributions. If missing, install it using the default package manager

* Download JBrowse2 driver script `jbrowse` : 

  ```sh
  $ cd /tmp
  $ curl -sLO https://raw.githubusercontent.com/krupadhruva/jbrowse/refs/heads/master/jbrowse
  $ chmod +x jbrowse
  $ sudo mv -i jbrowse /usr/local/bin/.
  ```



### Running

`jbrowse` is a simple Python 3 script to run JBrowse2 in a docker environment. It allows you to mount a local directory with samples prepared by you or persist samples processed by the JBrowse2 docker container.

From a shell, you can run `jbrowse` as follows.

```sh
$ jbrowse --help
usage: jbrowse [-h] {exec,start,stop} ...

positional arguments:
  {exec,start,stop}

options:
  -h, --help         show this help message and exit
```

#### Starting JBrowse2 server

```sh
$ jbrowse start --help
usage: jbrowse start [-h] [-u DOCKER_USERNAME] [-d DATA_DIRECTORY]

options:
  -h, --help            show this help message and exit
  -u DOCKER_USERNAME, --docker-username DOCKER_USERNAME
  -d DATA_DIRECTORY, --data-directory DATA_DIRECTORY
                        mount local directory for persistent data
```

Note: Attempting to start when already running will give an error

##### Start with ephemeral storage

To use JBrowse2 without you custom samples or need for persisting processed samples across server restarts, run the following. This will use the default docker image built and published.

```sh
$ jbrowse start
Started JBrowse2, open http://localhost:8080/
```

Visit the link http://localhost:8080/ for a browser based UI to interact with JBrowse2 service. Navigate through provided test samples or upload zip file with samples or download samples from pre-canned links from standard sources.

##### Start with persistent storage

If you are interested in using your own custom data or would like to persist any processed data from zip file you upload or downloaded from links, you will provide a local directory to persist data across JBrowse2 server runs. If you have your local directory at `~/bioe_samples`

```sh
$ jbrowse start -d ~/bioe_samples
Started JBrowse2, open http://localhost:8080/

$ ls -CF ~/bioe_samples
uploads/
```

Note: The service created a directory named `uploads` and you can see in in your local system (persisted even if you stop service)

##### Using file with custom links/URLs to sample data

Start the service with persistent storage as shown above. Copy a JSON file in following format and visit "[Download samples file](http://localhost:8080/download/)". You will see a list of links, you can download and process.

```json
{
	"links": [
		{
			"name": "<Readable name for the sample>",
			"url": "<Download link to zip file with samples>"
		},
		...
		...
	]
}
```

##### Uploading zip files with samples

Once service is running, navigate to "[Upload samples file](http://localhost:8080/upload/)". Select the downloaded file from your local system and upload. Once the service processes the file, it will take you to the main page where you can see the processed data under "user data" (Ephemeral/Persistent depending on how you have started the service).

##### Stopping the service

```sh
$ jbrowse stop
```
