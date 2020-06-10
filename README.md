<p align="center">
 <h1 align="center">TensorFlow for VAST Platform (VA Smalltalk)</h1>
  <p align="center">
    This is a TensorFlow wrapper for VA Smalltalk
    <!---
    <br>
    <a href="docs/"><strong>Explore the docs »</strong></a>
    <br>
    -->
    <br>
    <a href="https://github.com/vasmalltalk/tensorflow-vast/issues/new?labels=Type%3A+Defect">Report a defect</a>
    |
    <a href="https://github.com/vasmalltalk/tensorflow-vast/issues/new?labels=Type%3A+Feature">Request feature</a>
  </p>
</p>

TensorFlow is a Google open source machine learning library for research and production. And this is a wrapper to be used from a higher level language like VA Smalltalk.

## License

- The code is licensed under [MIT](LICENSE).
- The documentation is licensed under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).

## Supported platforms and versions

Currently we tested this wrapper on Linux and Windows, both on x86 and x64. In addition, we tested on ARM (Raspberry Pi 3B+ and Raspbian Buster), ARM64 (Rock64 and Armbian Buster) and ARM64 with GPU support (Nvidia Jetson Nano).

VA Smalltalk needed version is 9.2 or above and we have only tested on TensorFlow versions 1.13.x and 1.14.x.



## Installation

- Download the [9.2 ECAP 3 or newer from Instantiations](https://www.instantiations.com/ecap/). If any of the following steps cannot be achieved, it might be due to last minute changes in the TensorFlow configuration maps and/or improvements on the VAST VM or the base library. Please contact us for an up-to-date download.
- Install [TensorFlow for C](https://www.tensorflow.org/install/lang_c) for your operating system (download one of the tested versions).
- For Windows installations, make sure [Microsoft Visual C++ Redistributable for Visual Studio 2017](https://aka.ms/vs/15/release/VC_redist.x64.exe) is installed.
- Ensure tensorflow shared library (`.so` or `.dll`) is findable by OS lookup procedure or reference full path in VAST ini file.
- Add `TENSORFLOW_LIB` key/value under `[PlatformLibrary Name Mappings]` section in `abt.ini` file. Some examples:
```
TENSORFLOW_LIB=tensorflow
TENSORFLOW_LIB=/usr/local/lib/libtensorflow_framework.so.1.14.0
TENSORFLOW_LIB=/home/mpeck/Instantiations/TensorFlow/libtensorflow-cpu-linux-x86_64-1.14.0/lib/libtensorflow.so.1.14.0
TENSORFLOW_LIB=c:\Users\mpeck\Documents\Instantiations\tensorflow.dll
TENSORFLOW_LIB=z:\Instantiations\TensorFlow\libtensorflow-cpu-windows-x86_64-1.13.1\lib\tensorflow.dll
```
- Clone this repository.
- From the configuration map browser, import all versions of the `TensorFlow` map from `envy/TensorFlow.dat`. Then "Load With Required Maps" the latest version of it.
- Run SUnit Suite for all `TensorFlow` map (right click on the map -> `Test Loaded Applications`). You should see around 260 unit tests and most of them passing. As of this writing, VAST 9.2 ECAP 3 + TensorFlow CM 0.45, in Windows 7, achieves 215 tests passing, 3 expected failures, 40 errors and 1 freezes and crashes image (`TestTFBuffer>>#testNewFree`).
- Explore the [documentation](docs/).


## Examples

We will be submitting more and more examples in `TensorFlowExamplesApp`. So far the only working example is `LabelImage` which loads a pre-trained TensorFlow network and use it to recognize objects in images. You can read its class comments for details, instructions and possible uses.

There is also a [full detailed blog post about this example](https://dev.to/martinezpeck/recognizing-objects-in-images-with-tensorflow-and-smalltalk-1nep).

<img width="500" alt="LabelImage" src="https://pbs.twimg.com/media/EBOGuT1XoAAtQi1?format=jpg">

You can also run a Inception V3 like what is [described here](https://github.com/tensorflow/tensorflow/tree/master/tensorflow/examples/label_image/README.md):

<img width="500" alt="LabelImage" src="https://marianopeck.files.wordpress.com/2019/08/screen-shot-2019-08-02-at-11.12.35-am.png">

We also have a more advanced Object Detection example with bounding boxes, labels and scores. [This blog post](https://dev.to/martinezpeck/object-detection-with-tensorflow-and-smalltalk-15p7) goes over the glory details of this example:

<img width="500" alt="ObjectDetectionZoo" src="https://i1.wp.com/marianopeck.blog/wp-content/uploads/2019/08/Screen-Shot-2019-08-18-at-12.34.23-PM.png?resize=768%2C519&ssl=1">

## Running TensorFlow and VA Smalltalk on ARM

We believe that running TensorFlow and VA Smalltalk on ARM-based boards is really interesting. From limited devices such as a Raspberry Pi to a Nvidia Jetson.

We have compiled TensorFlow C library for ARM and ARM 64 and have been playing with different operating systems and boards such as Raspberry Pi 3B+ (Raspbian), Rock64 (Armbian) and soon Nvidia Jetson Nano and XT2.  

Building TensorFlow from scratch on ARM is a bit complicated so we try to document this process on blog posts as we learn. For the moment, you can checkout these:

- [Challenge Accepted: Build TensorFlow C Binding for Raspberry Pi in 2019](https://dev.to/martinezpeck/challenge-accepted-build-tensorflow-c-binding-for-raspberry-pi-in-2019-4f89)
- [The battle continues: Build TensorFlow C Binding for Raspberry Pi in 2019](https://dev.to/martinezpeck/the-battle-continues-build-tensorflow-c-binding-for-raspberry-pi-in-2019-553j)

## Blog Posts

- [Getting Started with Nvidia Jetson Nano, TensorFlow and Smalltalk](https://dev.to/martinezpeck/getting-started-with-nvidia-jetson-nano-tensorflow-and-smalltalk-23mk)
- [Recognizing objects in images with TensorFlow and Smalltalk](https://dev.to/martinezpeck/recognizing-objects-in-images-with-tensorflow-and-smalltalk-1nep)
- [Object Detection with TensorFlow and Smalltalk](https://dev.to/martinezpeck/object-detection-with-tensorflow-and-smalltalk-15p7)
- [TensorFlow — The first week](https://medium.com/mercap-tech-blog/tensorflow-the-first-week-c120762ef7cb)
- [Challenge Accepted: Build TensorFlow C Binding for Raspberry Pi in 2019](https://dev.to/martinezpeck/challenge-accepted-build-tensorflow-c-binding-for-raspberry-pi-in-2019-4f89)
- [The battle continues: Build TensorFlow C Binding for Raspberry Pi in 2019](https://dev.to/martinezpeck/the-battle-continues-build-tensorflow-c-binding-for-raspberry-pi-in-2019-553j)

## Acknowledgments

- [gera](https://github.com/gerasdf) for all his work on [the original code for Cuis Smalltalk](https://github.com/Cuis-Smalltalk/Machine-Learning) as well as for the port to VA Smalltalk.
- Github repository layout was generated with [Ba-St Github-setup project](https://github.com/ba-st/GitHub-setup).


## Contributing

Check the [Contribution Guidelines](CONTRIBUTING.md)
