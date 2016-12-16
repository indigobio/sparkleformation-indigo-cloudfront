SparkleFormation.new(:cloudfront).load(:base).overrides do
  description <<EOF
CloudFront distribution pointing to static.#{ENV['public_domain']}
EOF

  dynamic!(:cloudfront_distribution, 'assets', :origin => "static.#{ENV['public_domain']}")
end