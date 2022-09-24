##########################
# Security group with name
##########################
resource "aws_security_group" "this" {
  count = var.create ? 1 : 0

  name                   = var.name
  description            = var.description
  vpc_id                 = var.vpc_id
  #revoke_rules_on_delete = var.revoke_rules_on_delete

  tags = merge(
  {
    "Name" = format("%s", var.name)
  },
  var.tags,
  )
}

###################################
# Ingress - List of rules (simple)
###################################
# Security group rules with "cidr_blocks" and it uses list of rules names
resource "aws_security_group_rule" "ingress_rules" {
  count = var.create ? length(var.ingress_rules) : 0

  security_group_id = aws_security_group.this[0].id
  type              = "ingress"
  cidr_blocks      = var.ingress_cidr_blocks
  description      = var.rules[var.ingress_rules[count.index]][3]
  from_port = var.rules[var.ingress_rules[count.index]][0]
  to_port   = var.rules[var.ingress_rules[count.index]][1]
  protocol  = var.rules[var.ingress_rules[count.index]][2]
}

##########################
# Ingress - Maps of rules
##########################
# Security group rules with "source_security_group_id", but without "cidr_blocks" and "self"
resource "aws_security_group_rule" "ingress_with_source_security_group_id" {
  count = var.create ? length(var.ingress_with_source_security_group_id) : 0

  security_group_id = aws_security_group.this[0].id
  type              = "ingress"

  source_security_group_id = var.ingress_with_source_security_group_id[count.index]["source_security_group_id"]
  description = lookup(
  var.ingress_with_source_security_group_id[count.index],
  "description",
  "Ingress Rule",
  )

  from_port = lookup(
  var.ingress_with_source_security_group_id[count.index],
  "from_port",
  var.rules[lookup(
  var.ingress_with_source_security_group_id[count.index],
  "rule",
  "_",
  )][0],
  )
  to_port = lookup(
  var.ingress_with_source_security_group_id[count.index],
  "to_port",
  var.rules[lookup(
  var.ingress_with_source_security_group_id[count.index],
  "rule",
  "_",
  )][1],
  )
  protocol = lookup(
  var.ingress_with_source_security_group_id[count.index],
  "protocol",
  var.rules[lookup(
  var.ingress_with_source_security_group_id[count.index],
  "rule",
  "_",
  )][2],
  )
}

# Security group rules with "cidr_blocks", but without "ipv6_cidr_blocks", "source_security_group_id" and "self"
resource "aws_security_group_rule" "ingress_with_cidr_blocks" {
  count = var.create ? length(var.ingress_with_cidr_blocks) : 0

  security_group_id = aws_security_group.this[0].id
  type              = "ingress"

  cidr_blocks = split(
  ",",
  lookup(
  var.ingress_with_cidr_blocks[count.index],
  "cidr_blocks",
  join(",", var.ingress_cidr_blocks),
  ),
  )
  description = lookup(
  var.ingress_with_cidr_blocks[count.index],
  "description",
  "Ingress Rule",
  )

  from_port = lookup(
  var.ingress_with_cidr_blocks[count.index],
  "from_port",
  var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")][0],
  )
  to_port = lookup(
  var.ingress_with_cidr_blocks[count.index],
  "to_port",
  var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")][1],
  )
  protocol = lookup(
  var.ingress_with_cidr_blocks[count.index],
  "protocol",
  var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")][2],
  )
}

#################
# End of ingress
#################

##################################
# Egress - List of rules (simple)
##################################
# Security group rules with "cidr_blocks" and it uses list of rules names
resource "aws_security_group_rule" "egress_rules" {
  count = var.create ? length(var.egress_rules) : 0

  security_group_id = aws_security_group.this[0].id
  type              = "egress"

  cidr_blocks      = var.egress_cidr_blocks
  description      = var.rules[var.egress_rules[count.index]][3]

  from_port = var.rules[var.egress_rules[count.index]][0]
  to_port   = var.rules[var.egress_rules[count.index]][1]
  protocol  = var.rules[var.egress_rules[count.index]][2]
}

#########################
# Egress - Maps of rules
#########################
# Security group rules with "source_security_group_id", but without "cidr_blocks" and "self"
resource "aws_security_group_rule" "egress_with_source_security_group_id" {
  count = var.create ? length(var.egress_with_source_security_group_id) : 0

  security_group_id = aws_security_group.this[0].id
  type              = "egress"

  source_security_group_id = var.egress_with_source_security_group_id[count.index]["source_security_group_id"]
  description = lookup(
  var.egress_with_source_security_group_id[count.index],
  "description",
  "Egress Rule",
  )

  from_port = lookup(
  var.egress_with_source_security_group_id[count.index],
  "from_port",
  var.rules[lookup(
  var.egress_with_source_security_group_id[count.index],
  "rule",
  "_",
  )][0],
  )
  to_port = lookup(
  var.egress_with_source_security_group_id[count.index],
  "to_port",
  var.rules[lookup(
  var.egress_with_source_security_group_id[count.index],
  "rule",
  "_",
  )][1],
  )
  protocol = lookup(
  var.egress_with_source_security_group_id[count.index],
  "protocol",
  var.rules[lookup(
  var.egress_with_source_security_group_id[count.index],
  "rule",
  "_",
  )][2],
  )
}

# Security group rules with "cidr_blocks", but without "ipv6_cidr_blocks", "source_security_group_id" and "self"
resource "aws_security_group_rule" "egress_with_cidr_blocks" {
  count = var.create ? length(var.egress_with_cidr_blocks) : 0

  security_group_id = aws_security_group.this[0].id
  type              = "egress"

  cidr_blocks = split(
  ",",
  lookup(
  var.egress_with_cidr_blocks[count.index],
  "cidr_blocks",
  join(",", var.egress_cidr_blocks),
  ),
  )

  description = lookup(
  var.egress_with_cidr_blocks[count.index],
  "description",
  "Egress Rule",
  )

  from_port = lookup(
  var.egress_with_cidr_blocks[count.index],
  "from_port",
  var.rules[lookup(var.egress_with_cidr_blocks[count.index], "rule", "_")][0],
  )
  to_port = lookup(
  var.egress_with_cidr_blocks[count.index],
  "to_port",
  var.rules[lookup(var.egress_with_cidr_blocks[count.index], "rule", "_")][1],
  )
  protocol = lookup(
  var.egress_with_cidr_blocks[count.index],
  "protocol",
  var.rules[lookup(var.egress_with_cidr_blocks[count.index], "rule", "_")][2],
  )
}

################
# End of egress
################
