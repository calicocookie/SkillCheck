// 選択肢 1
data "aws_iam_policy_document" "answer_1" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::ce-exam/tmp",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::ce-exam/tmp/*",
    ]
  }
}

// 選択肢 2
data "aws_iam_policy_document" "answer_2" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::ce-exam",
    ]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"

      values = [
        "tmp"
      ]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::ce-exam/tmp/*",
    ]
  }
}

// 選択肢 3
data "aws_iam_policy_document" "answer_3" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListObjects",
    ]

    resources = [
      "arn:aws:s3:::ce-exam/tmp/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::ce-exam/tmp/*",
    ]
  }
}

// 選択肢 4
data "aws_iam_policy_document" "answer_4" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::ce-exam/tmp/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::ce-exam/tmp/*",
    ]
  }
}
