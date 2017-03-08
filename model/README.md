# Model assertion

As the [Ubuntu Core documentation](https://docs.ubuntu.com/core/en/guides/build-device/image-building) mentions, building an image requires to have a **signed** model assertion.

This folder contains both the *JSON* file and its *signed* version.

It has been signed with Boundary Devices key which you cannot replicate.

However, if you plan on signing the image yourself, you'll need to register a key to your account as follows:
```
$ sudo snap login <ubuntu_email>
$ snap create-key <keyname>
$ snapcraft register-key <keyname>
```

Then getting on your [Ubuntu dev account](https://myapps.developer.ubuntu.com/dev/account/) you should see an **Account-Id** which needs to be copied to the *nitrogen-model.json* file.

Finally, the *JSON* can be signed:
```
$ cat nitrogen-model.json | snap sign -k <keyname> &> nitrogen.model
```
