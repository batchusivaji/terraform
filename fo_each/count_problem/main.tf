resource "local_file" "file" {
  count = length(var.filenames)
  content = "hello"
  filename = var.filenames[count.index]
}