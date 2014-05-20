# fluentd-plugin-ci

[![Build Status](https://secure.travis-ci.org/sonots/fluentd-plugin-ci.png?branch=master)](http://travis-ci.org/sonots/fluentd-plugin-ci)

a repository to test plugins in batch with new fluentd version

## How to add tested plugins

Add to [Gemfile](./Gemfile)

## How to specify Fluentd version

Change [this line](./Gemfile#L3) of Gemfile. 

## How to start test on travis

For example, 

```
$ git commit --allow-empty -m 'test with fluentd v0.10.47'
$ git push origin master
```

Then, travis will automatically start testing by github webhook. 
