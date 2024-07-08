# resource "aws_iam_user" "users" {
#   for_each = toset(["jenny","rose","lissa","jisoo"])  
#   name = each.key  
# }

# resource "aws_iam_group" "blackpink" {
#   name = "blackpink"
# }

# resource "aws_iam_group_membership" "team" {
#   name = "group-membership"

#   users = [
#     for i in aws_iam_user.users : i.name
#   ]

#   group = aws_iam_group.blackpink.name
# }