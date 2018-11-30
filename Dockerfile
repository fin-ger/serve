FROM golang:1.11-alpine

RUN apk update && apk add git gcc libc-dev
ADD . /go/src/github.com/jpillora/serve
WORKDIR /go/src/github.com/jpillora/serve
RUN go get ./...
RUN go install -ldflags '-linkmode=external "-extldflags=-static"'
RUN mkdir /content

FROM scratch
COPY --from=0 /go/bin/serve .
COPY --from=0 /content .
WORKDIR /content
EXPOSE 3000
ENTRYPOINT ["/serve"]
CMD []
