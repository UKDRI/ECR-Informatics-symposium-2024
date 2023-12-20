# Dockerfile notes

The Dockerfile included in this repo builds an image that contains the R dependencies for the ADDI workshop from the `renv.lock` file.

Note that it does not copy the data into the image to keep it minimal in size.


```
docker build --platform amd64 -t r-environment --load -f Dockerfile .
```

You can mount any data/scripts you like with it like so:

```
docker run -it --rm -v /path/to/your/data:/project/data r-environment
```