# bookappTest1

**This will be the base model to build the book project**

## Version 1
This version uses ARkit's image tracking configuration to anchor objects onto images:
 
>You can upload our own images to act as the anchor
* Images are called in the function viewDidLoad()
* The practice image is the cover of The Nicomachean Ethics and the front page of the Ulysses Gabler edition from 1986
* You can change/add images in the 'Photos' folder
* You must change the scale of any added image (width: 0.2m)

>Objects can be loaded to anchor onto whatever image
* Objects are called in the function viewWillAppear()
* They must be stored in the 'art.scnassets' folder
* Objects must be scaled to match the image
