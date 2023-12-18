# stream-converter

This tool will help you stream data in bytes from point A to point B while whatever available processing/converting.
You can control the download and upload buffer sizes, as well as the stream converter's concurrency.

## Available adapters

The stream converter relies on the `io.Reader` & `io.Writer` interfaces, so you can hook up any adapter you might need. At the moment
the stream converter comes with an `AWS S3` adapter to crawl, read from and write to an S3 bucket.

- AWS S3: You can 

## Usage

### CLI

```bash
$ make build
```

```bash
$ stream-converter \
    --input s3://input-bucket \
    --input-processor=base64-proto \
    --output s3://output-bucket \
    --output-processor=base64-json \
    --log-level INFO \
    --metrics-endpoint=otel-collector:port \
    --profiler
```

### API

```go
package main

import streamConverter from "github.com/derrandz/stream-converter"

func main() {
    strm := streamConverter.Stream(
        // TODO
    )
}

```

## Contributions

Contributions are welcome. Please make sure to read the [Contributing Guide](CONTRIBUTING.md) and [Code of Conduct](CODE_OF_CONDUCT.md) before making a pull request.

## License

[MIT](LICENSE)

