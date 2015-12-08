# avamar_config

####Table of Contents
1. [Overview](#overview)
2. [Module Description - What is the avamar module and why is it useful](#module-description)
3. [Setup - The basics of getting started with avamar](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with Avamar](#beginning-with-Avamar)
4. [License](#license)

##Overview

Allows configuration of Avamar on target host

##Module Description

This module will allow the given host to install and configure Avamar as specified.

This module was tested and works great within RedHat Satellite 6.1.

##Setup

##Setup Requirements

This will work with RPM systems only. (If you'd like to modify this, please feel free to submit changes)

##Beginning with run once

```puppet
    avamar {
      "class_enabled" => false,
	  "ensure_package" => true,
	  "admin_server" => "avadmin.example.com",
	  "server_domain" => "test01",
    }
```

    class_enabled  (Boolean: default [false])
    - Enables/Disables the process
    ensure_package (Boolean: default [true])
    - Enables/Disables package installation requirements
    admin_server (String)
    - Avamar Administration Server
    server_domain (String)
    - Avamar server domain

##License

Copyright 2015 Eric B

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
