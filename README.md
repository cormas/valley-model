# Valley model

A small valley where irrigation canals carry water from a spring to the fields, footpaths join fields both ways, and farmers who trust each other share water.

The model is the example of the [reference page on links](https://cormas.org/docs/reference/links) for [Cormas](https://github.com/cormas/cormas). Every snippet on that page runs on this model.

## Install

The model needs a version of Cormas with links, which for now is the `dev` branch. In a Cormas image, execute:

```st
Metacello new
    repository: 'github://cormas/valley-model:main/src';
    baseline: 'ValleyModel';
    load.
```

Then open a simulation window, and choose `initValley` and `step`