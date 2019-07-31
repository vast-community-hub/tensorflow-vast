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

## Installation

- Download the [latest ECAP from Instantiations](https://www.instantiations.com/ecap/)
- Install [TensorFlow for C](https://www.tensorflow.org/install/lang_c)
- Ensure tensorflow shared library is in path or reference full path in VAST ini file
- Add ``[PlatformLibrary Name Mappings]`` entry in `abt.ini` file:
			TENSORFLOW_LIB=tensorflow
								or
			TENSORFLOW_LIB=/absolute/path/to/tensorflow
- Import and load the `TensorFlow` configuration map from `TensorFlow.dat`.
- Run SUnit Suite for all `TensorFlow` map.
- Explore the [documentation](docs/)


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
