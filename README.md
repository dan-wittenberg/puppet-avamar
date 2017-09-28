# puppet-avamar
[![Build Status](https://travis-ci.org/Ramorous/puppet-avamar.svg?branch=master)](https://travis-ci.org/Ramorous/puppet-avamar)
[![Puppet Forge](https://img.shields.io/puppetforge/dt/Ramorous/avamar.svg)](https://forge.puppetlabs.com/Ramorous/avamar)
[![Puppet Forge](https://img.shields.io/puppetforge/v/Ramorous/avamar.svg)](https://forge.puppetlabs.com/Ramorous/avamar)
[![Puppet Forge](https://img.shields.io/puppetforge/f/Ramorous/avamar.svg)](https://forge.puppetlabs.com/Ramorous/avamar)
[![License (Apache 2.0)](https://img.shields.io/badge/license-Apache-blue.svg)](https://opensource.org/licenses/Apache-2.0)

#### Table of Contents
1. [Overview](#overview)
2. [Module Description - What is the Avamar module and why is it useful](#module-description)
3. [Setup - The basics of getting started with Avamar](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with Avamar](#beginning-with-Avamar)
4. [Reference](#reference)
5. [License](#license)

## Overview

Allows configuration of [Avamar][1] on target host

## Module Description

This module will allow the given host to install and configure [Avamar][1] as specified.

This module was tested and works great within RedHat Satellite 6.1.

## Setup

### Setup Requirements

This will work with RPM systems only. (If you'd like to modify this, please feel free to submit changes)

This class assumes that you have setup a repository containing the Avamar packages as this class does not create any repository resources since Avamar packages are not available for download without a license.

### Beginning with Avamar

```puppet
    avamar {
        "class_enabled"  => false,
        "ensure_package" => true,
        "admin_server"   => "avadmin.example.com",
        "server_domain"  => "test01",
    }
```

## Reference

### Parameters within `avamar`

#### `admin_server`
[Avamar][1] Administration Server

String: default 'ben061012.example.com'

#### `class_enabled`
Enables/Disables the management of any [Avamar][1] packages, files, etc. This option will still function, but will be deprecated in the future in favor of the `$manage_package`, `$manage_register`, and `$manage_service` options.

Boolean: default false

#### `manage_package`
Should the class control whether the package(s)

Boolean: default true

#### `manage_register`
Should the class try to register the [Avamar][1] client with the admin server

Boolean: default true

#### `manage_service`
Should the class control the [Avamar][1] service

Boolean: default true

#### `package_ensure`
The ensure value for the package resource

String: default 'installed'

#### `package_name`
Name of the package to be installed/required.

String: default 'AvamarClient'

#### `rman_package_ensure`
The ensure value for the Oracle "RMAN" package resource

String: default 'absent'

#### `rman_package_name`
Name of the Oracle "RMAN" package to be installed/required.

String: default 'AvamarRMAN'

#### `server_domain`
[Avamar][1] server domain

String: default 'ben1253'

#### `service_enable`
Should the [Avamar][1] service be enabled on the system

Boolean: default true

#### `service_ensure`
The ensure value for the [Avamar][1] service resource

String: default 'running'

#### `service_name`
The name of the [Avamar][1] service

String: default 'avagent'

## License

Copyright 2015 Eric B

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

[1]: https://www.emc.com/data-protection/avamar.htm "Avamar"
