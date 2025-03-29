# This is a cheatsheet to get to things quickly without having to look it up

`show debug logs`
 sf apex tail log --color

`set remote site setting`
--> make sure to set that up

`Set up external credentials`
--> make sure to set that up

`Set up named credentials`
--> make sure to set that up

`Steps to authorize github`
1. clone the repo
2. sf org display --verbose --json > auth.json
3. copy the auth url
4. go to github actions
5. under seccrets create a new secret called DEV_HUB_AUTH_URL
6. paste the auth url in the secret value