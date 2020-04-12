# Stacks

## Development

To create bionic tiny stack images run:
```
./scipts/create-stack.sh [ -v <version>]
```
This will generate `humourmind/build:<version>` and `humourmind/run:<version>` images. Replace `humourmind` with your repository name.

To use this stack see the `pack create-builder` [documentation](https://github.com/buildpack/pack/blob/master/README.md#working-with-builders-using-create-builder).

This creates a CNB java builder with a tiny just enough run time image.
`pack create-builder humourmind/cnb-java-builder-tiny:0.7.2 --builder-config builder.toml`
