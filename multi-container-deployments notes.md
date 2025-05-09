## Multi-container Setup

1. Push code to GitHub
1. Travis automatically pulls repo
1. Travis builds a *test* image, tests code
1. Travis builds *prod* images
1. Travis pushes built *prod* images to Docker Hub
1. Travis pushes project to AWS EB (a message)
1. EB pulls images from Docker Hub, deploys

## Travis Setup

1. Specify Docker as a dependency
1. Build test version of React project
1. Run tests
1. Build prod versions of all projects
1. Push all to Docker Hub
1. Tell Elastic Beanstalk to update