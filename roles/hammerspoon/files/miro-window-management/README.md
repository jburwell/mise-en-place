# Miro's windows management

Other Hammerspoon configurations and projects (e.g. [Spectacle](https://www.spectacleapp.com/)) move windows in halves using arrows, and in corners using other counterintuitive shortcuts, like letters. With this configuration you will be able to move the window in halves and in corners using only arrows. You would also be able to resize them by thirds, quarters, or halves.

![example](https://github.com/miromannino/hammerspoon-config/raw/imgs/example.gif)


## Shortcuts

### Hyper key

The hyper key is defined as `ctrl` + `alt` + `cmd`. This means that each shortcut will start by pressing these three keys. If you consider this too verbose for your personal keyboard interactions, you can also change this key by editing the file `init.lua`, or you can replace an unused key (e.g. caps lock key) with [Karabiner](https://pqrs.org/osx/karabiner/) and [Seil](https://pqrs.org/osx/karabiner/seil.html.en) to act as hyper key.

### Move in halves

 - `hyper` + `up`: move to the top half of the screen
 - `hyper` + `right`: move to the right half of the screen
 - `hyper` + `down`: move to the bottom half of the screen
 - `hyper` + `left`: move to the left half of the screen

By repeating these shortcuts the window is resized to be one third or two thirds and again in one half. 

### Move to corners

 - `hyper` + `up` + `right`: move the window to the top-right corner
 - `hyper` + `down` + `right`: move the window to the bottom-right corner
 - `hyper` + `up` + `left`: move the window to the top-left corner
 - `hyper` + `down` + `left`: move the window to the bottom-left corner

 When the window is in the corner, it will have one half of screen height and one half of screen width. 
 The arrows can be used to expand the height/width to be one third, two thirds or again one half. 
 For example if the window is in the top-right corner, pressing `hyper` + `up` the window height will be resized to be one third, while pressing `hyper` + `right` the window width will be resized to be one third; in this case `hyper` + `left` and `hyper` + `down` will move the window to the top-left and bottom-right corners, respectively.

### Expand to fit the entire height or width

These are useful in case the window is in one of the corners.

 - `hyper` + `up` + `down`: expand the height to fit the entire screen height
 - `hyper` + `right` + `left`: expand the width to fit the entire screen width

### Expand to fullscreen

 - `hyper` + `f`: expand to be full screen

Note that in case the window is resized to be a half of the screen, you can also use `hyper` + `up` + `down` (or `hyper` + `right` + `left`) to resize the window full screen.

As the other shortcuts, `hyper` + `f` can be pressed multiple times to obtain a centered window of three fourth and one half of height and width. This behaviour can be customized.

## Reviews

Here comments from the users, just as reviews.

> it's something I have been looking for all my life! It is really intuitive and ingenious once you see the magic it can do.
> 
> &mdash; [rxng](https://github.com/miromannino/hammerspoon-config/issues/1)

> Really loving the arrow based positioning, thanks for making this ! I can now uninstall “spectacle” which I was using for the same purpose but the key bindings were unintuitive.
>
> &mdash; Gaurav

## Articles

A suggested tutorial on Mic Sumner: https://www.micsumner.com/how-to-organise-window-viewing-areas-in-mac-os/


## License (MIT)

Copyright (c) 2016 Miro Mannino

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
