SparkleFormation.new(:cloudfront).load(:base, :git_rev_outputs).overrides do
  description <<EOF
CloudFront distribution pointing to static.#{ENV['public_domain']}
EOF

  dynamic!(:cloudfront_distribution, 'assets', :origin => "static.#{ENV['public_domain']}")
end
