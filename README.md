# Cedilla Consortial Service

## Overview

This service exposes several RESTish webservice endpoints that the Cedilla system can use to determine a user's campus (consortial) affiliation. This version uses an XML file as its data source.

## Installation

* Clone this repository

* Run ```> bundle install```

* Rename consortial.yaml.example to consortial.yaml and update its contents

* Start the server ```> thin -R config.ru start -p[port]```

It is recommended that you run the service as a daemon from a shell script.

## Usage

Cedilla is already programmed to make the appropriate calls to this service. If you want to use it for other purposes, such as a call from a Cedilla client implementation or another system altogether, you can contact it via one of the following three methods:

* Using the IP address recorded in the HTTP Headers
> curl http://my.server.edu:port/ip
This approach will extract the IP address included in the HTTP Headers of the incoming call and will return the appropriate campus/consortial identifier or an HTTP 404 error if the IP cannot be mapped to a value.

* Using a specified IP address
> curl http://my.server.edu:port/ip/123%2E123%2E123%2E123
This approach will use the specified IP address to find a matching campus/consortial identifier. If there is no match the service returns an HTTP 404

* Using a campus/consortial identifier (e.g. CAMPUS-A)
> curl http://my.server.edu:port/campus/CAMPUS-A
This approach will attempt to find the specified identifier and will return the address of the VPN if available or an IP if there is no VPN address. If the identifier cannot be matched an HTTP 404 is returned.

The system makes use of the settingins in the ./config/consortial.yaml file. The file is divided into 2 sections. 

* The first section can be used to tell the service to retrieve the XML file from an external web service. You can defined the location of the service and the number of days to allow the file to age before retrieving a new copy

* The second section identifies the location of the XML file and all of the XPath setting needed to translate between IP addresses and Campus/Consortial identifiers

## Configuring Cedilla To Use This Service

The Cedilla aggregator does not use a consortial service by default. You must tell it where your service is located by updating the ./config/application.yaml configuration file.

Open the configuration file and uncomment the following lines and enter in the address of your service
```
consortial_service:
  timeout: 10000
  translate_from_code: 'http://localhost:3106/campus/?'
  translate_from_ip: 'http://localhost:3106/ip/?'
```

## License

The Cedilla Ruby Gem uses adheres to the [BSD 3 Clause](./LICENSE.md) license agreement.
