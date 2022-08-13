# Photo Cook

## How we integrated AI and Machine Learning

We used a model called the ssd-mobilenet model for object detection training. It took us at least 10 hours to 
debug, train and freeze the model correctly. 

We took another few hours trying to search stackoverflow on how to use the frozen model without incorporating 
the `object_detection_utils` library.

Lastly, we had to hand-label 100+ images for the training of the ssd_mobilenet model.

## Inspiration

We found that in our daily lives finding cooking ideas seem to be a challenge. Searching recipes up and/or 
finding ideas for lunch with the correct ingredients involved proves to be immensely difficult the normal human being.

Moreover, looking at the App store, we found that no apps actually involved machine learning and object detection 
to increase the user experience by allowing the users to easily snap a picture of what they have and recommending them 
some ideas for lunch.
## What it does

We allow the user to snap a photo easily using flutter, then this image gets sent to an api coded in flask.

Next, the backend will process the image into a tensor, and input it into the frozen object-detection model.

## How we built it

This app and api uses flutter and python as its languages. 

We have flutter as the front end, flask as the backend, and lastly, tensorflow as the model trainer.

We spent much time hand-labeling the training set's images that were collected and processed with a nikon camera and opencv-python .

After labeling the images, Eddie spent 5-7 hours debugging and learning how to train and freeze the ssd-mobilenet object
detection model in google colabs since.



## Challenges we ran into
- Heroku does not run well with tensorflow (takes up too mcuh RAM)
- API data transfer 
- After Eddie collected the images and hand labeled where each object is in each image, he went to train the model. However when he went to train the model
he got an error which made him figure out (in another 2 hours) that the images from the nikon were 6000x4000pixels, which caused Eddie to 
create another script to resize the images into (180x120) and then handle label them once again. 
- Much smaller bugs involving flutter and tensorflow version control
## Accomplishments that we're proud of

- We successfully trained an object detection model
- We successfully coded an api and flutter communication system

## What we learned

- More in-depth reasonings behind different bugs and errors 
- How to train an object detection model efficiently.
- Flutter http requests with files

## What's next for Photo Cook

Search bar for recipes, stronger recommendation system with ml based on the recipes the user tried,
better ui, heroku support, and api documentation.

