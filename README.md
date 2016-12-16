## sparkleformation-indigo-cloudfront
This repository contains a SparkleFormation template that creates an
AWS CloudFront distribution.  The CloudFront distribution can pull
assets from either an S3 bucket, or from a URL.

SparkleFormation is a tool that creates CloudFormation templates, which are
static documents declaring resources for AWS to create.

### Dependencies

The template requires an external Sparkle Pack gem, which is noted in
the Gemfile and the .sfn file.  This gem interacts with AWS through the
`aws-sdk-core` gem to identify or create S3 buckets.

### Parameters

When launching the compiled CloudFormation template, you will be prompted for
some stack parameters:

| Parameter | Default Value | Purpose |
|-----------|---------------|---------|
| AssetsComment | `ENV['public_domain']` | Simply an identifier for the CloudFront distribution |
| AssetsPriceClass | PriceClass_100 | https://aws.amazon.com/cloudfront/pricing/ |

### Notes

While the template *should* support assets in an S3 bucket, I haven't
tested creating a CloudFront distribution that uses one. YMMV.
