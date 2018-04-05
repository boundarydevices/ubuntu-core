# Model assertion

As the [Ubuntu Core documentation](https://docs.ubuntu.com/core/en/guides/build-device/image-building) mentions, building an image requires to have a **signed** model assertion.

This folder contains both the *JSON* file and its *signed* version.

It has been signed with Boundary Devices key which you cannot replicate.

However, if you plan on signing the image yourself, you need to make sure a key is associated to your account:
```
$ sudo snap login <ubuntu_email>
$ sudo snap keys
```

If not, you need to create one:
```
$ snap create-key <keyname>
$ snapcraft register-key <keyname>
```

Finally, the *JSON* can be signed:
```
$ cat nitrogen-model.json | snap sign [-k <keyname>] &> nitrogen.model
```
