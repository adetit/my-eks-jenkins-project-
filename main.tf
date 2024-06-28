provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "mongodb" {
  ami           = "ami-xxxxxxxx"  # Use an outdated Linux AMI
  instance_type = "t2.micro"

  tags = {
    Name = "MongoDB"
  }
}

resource "aws_s3_bucket" "mongodb_backups" {
  bucket = "mongodb-backups-bucket"
  acl    = "public-read"
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "myAppp-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.public.*.id
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks_cluster_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
