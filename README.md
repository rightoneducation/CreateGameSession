# CreateGameSession

Lambda hosted in AWS to create a game session. The lambda is responsible for:

- Fetching the game
- Validating for Basic mode
- Generating a unique game code
- Creating the game session
- Returning the created game session

Following are the expected parameters to call this endpoint:

- `gameId` ID of the game used to create the game session. Questions and information are copied from this game.
- `isAdvancedMode` Boolean value indicating if this game session is for Basic or Advanced mode. Basic mode games require that all questions have 4 answers associated with them (1 correct and 3 incorrect). If not, the endpoint will return an error.

Example of request body

```JSON
{
    "gameId": 1,
    "isAdvancedMode": false
}
```

## Build for Deployment

When a new feature has been developed, use the following command to create a zip package, which can then be used to deploy to AWS Lambda. Notice that the Swift version may need to be updated in the future when newer versions become available.

```shell
docker run \
  --rm \
  --volume "$(pwd)/:/src" \
  --workdir "/src/" \
  swift:5.6.1-amazonlinux2 \
  /bin/bash -c "yum -y install libuuid-devel libicu-devel libedit-devel libxml2-devel sqlite-devel python-devel ncurses-devel curl-devel openssl-devel libtool jq tar zip && swift build --product CreateGameSession -c release && scripts/package.sh CreateGameSession"
```

Note: In order to build the project, you'll need access to `GraphQLEndpoint+Keys.swift` which is currently not in the repo. Please reach out on Slack as needed so that you can build the project fully. Alternatively, this can be done by running Amplify locally and creating the file yourself or adding the required keys to connect to the local instance.
