<p align="center">
 <h1 align="center">TensorFlow for VASmalltalk</h1>
  <p align="center">
    This is a TensorFlow wrapper for VASmalltalk
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

TensorFlow is a Google open source machine learning library for research and production. And this is a wrapper to be used from a higher level language like VASmalltalk.

## License
- The code is licensed under [MIT](LICENSE).
- The documentation is licensed under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).

## Supported platforms and versions
Currently we tested this wrapper on Linux and Windows, both on x86 and x64. In addition, we tested on ARM (Raspberry Pi 3B+ and Raspbian Buster) and ARM64 (Rock64 and Armbian Buster).

We have only tested on TensorFlow versions 1.13.x and 1.14.x.

## Installation

- Download the [latest ECAP from Instantiations](https://www.instantiations.com/ecap/).
- Install [TensorFlow for C](https://www.tensorflow.org/install/lang_c) for your operating system (download one of the tested versions).
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
- Run SUnit Suite for all `TensorFlow` map (right click on the map -> `Test Loaded Applications`). You should see around 260 unit tests and most of them passing.
- Explore the [documentation](docs/).


## Examples
We will be submitting more and more examples in `TensorFlowExamplesApp`. So far the only working example is `LabelImage` which loads a pre-trained TensorFlow network and use it to recognize objects in images. You can read its class comments for details, instructions and possible uses.

![LabelImage](https://marianopeck.files.wordpress.com/2019/08/screen-shot-2019-08-01-at-10.43.25-pm.png)


## Running TensorFlow and VASmalltalk on ARM

We believe that running TensorFlow and VASmalltalk on ARM-based boards is really interesting. From limited devices such as a Raspberry Pi to a Nvidia Jetson.

We have compiled TensorFlow C library for ARM and ARM 64 and have been playing with different operating systems and boards such as Raspberry Pi 3B+ (Raspbian), Rock64 (Armbian) and soon Nvidia Jetson Nano and XT2.  

Building TensorFlow from scratch on ARM is a bit complicated so we try to document this process on blog posts as we learn. For the moment, you can checkout these:

- [Challenge Accepted: Build TensorFlow C Binding for Raspberry Pi in 2019](https://dev.to/martinezpeck/challenge-accepted-build-tensorflow-c-binding-for-raspberry-pi-in-2019-4f89)
- [The battle continues: Build TensorFlow C Binding for Raspberry Pi in 2019](https://dev.to/martinezpeck/the-battle-continues-build-tensorflow-c-binding-for-raspberry-pi-in-2019-553j)

## Acknowledgments

- [gera](https://github.com/gerasdf) for all his work on [the original code for Cuis Smalltalk](https://github.com/Cuis-Smalltalk/Machine-Learning) as well as for the port to VASmalltalk.
- Github repository layout was generated with [Ba-St Github-setup project](https://github.com/ba-st/GitHub-setup).


## Contributing

Check the [Contribution Guidelines](CONTRIBUTING.md)
