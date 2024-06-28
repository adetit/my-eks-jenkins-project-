output "mongodb_instance_id" {
  value = aws_instance.mongodb.id
}

output "s3_bucket_name" {
  value = aws_s3_bucket.mongodb_backups.bucket
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}
