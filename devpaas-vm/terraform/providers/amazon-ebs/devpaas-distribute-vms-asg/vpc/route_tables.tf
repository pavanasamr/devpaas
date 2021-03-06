# --------------------------------------------------------------------------------------
#              ROUTING TABLES & ROUTES
# --------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------
# RouteTable PUBLIC for Subnet PUBLIC
# --------------------------------------------------------------------------------------
resource "aws_route_table" "mm_devpaas_rt_public" {

  vpc_id = "${aws_vpc.mm_devpaas_vpc.id}"

  tags {
    Name = "${var.project_name}-Public"
  }
}

# Route to IGW Gateway for Subnet Public

resource "aws_route" "mm_devpaas_route_public" {

  route_table_id          = "${aws_route_table.mm_devpaas_rt_public.id}"
  gateway_id              = "${aws_internet_gateway.mm_devpaas_igw.id}"
  destination_cidr_block  = "0.0.0.0/0"

}

# Route Table association: Route Table Public <--> Public Subnet

resource "aws_route_table_association" "mm_devpaas_rta_sbpublic" {

  route_table_id  = "${aws_route_table.mm_devpaas_rt_public.id}"
  subnet_id       = "${aws_subnet.mm_devpaas_sb_public.id}"

}



# --------------------------------------------------------------------------------------
# RouteTable PRIVATE for Subnet PRIVATE
# --------------------------------------------------------------------------------------
resource "aws_route_table" "mm_devpaas_rt_private" {

  vpc_id = "${aws_vpc.mm_devpaas_vpc.id}"

  tags {
    Name = "${var.project_name}-Private"
  }
}

# Route to the NAT Gateway for Subnet Private

resource "aws_route" "mm_devpaas_route_private" {
  route_table_id          = "${aws_route_table.mm_devpaas_rt_private.id}"
  nat_gateway_id          = "${aws_nat_gateway.mm_devpaas_natgw.id}"
  destination_cidr_block  = "0.0.0.0/0"
}


# Route Table association: Route Table Private <--> Private Subnet

resource "aws_route_table_association" "mm_devpaas_rta_sbprivate" {

  route_table_id  = "${aws_route_table.mm_devpaas_rt_private.id}"
  subnet_id       = "${aws_subnet.mm_devpaas_sb_private.id}"

}
