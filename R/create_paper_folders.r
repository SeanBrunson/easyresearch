#' Main Function to Setup Folder Structure
#'
#' Creates folders within new paper project
#'
#' @param paper_name Name of paper PDF
#' @export
#' @author Sean Brunson
#'
#' @examples
#' \dontrun{
#' paper_name <- "TestBook"
#'
#' create_paper(paper_name)
#' }

create_paper <- function(paper_name){
    # Create folders:
    folder_names <- c("analyze", "clean_data", "data_raw", "data_final",
                      "helper_functions", "results")

    for(folder in folder_names){
        if(!file.exists(folder)){
            dir.create(folder, showWarnings = FALSE)
        }
    }

    # Create paper folder:
    folder_paper <- system.file("paper", package = "easyresearch")

    if(!file.exists("paper")){
        # Get names of folders to copy into paper folder:
        folder_paper_files <- list.files(folder_paper, full.names = TRUE)

        # Create paper folder:
        dir.create("paper", showWarnings = FALSE)

        # Copy folders to paper folder:
        file.copy(folder_paper_files, "paper/", recursive = TRUE)

        # Create paper YAML file to paper folder.
        # This will setup up the PDF file format for the full
        # paper using the bookdown package:
        yaml_input = paste0('book_filename: ', paper_name,
                            '\nrmd_subdir: ["paper/sections"]\n')
        write.table(yaml_input,
                    col.names = FALSE, row.names = FALSE,
                    qmethod = "double", quote = FALSE,
                    file = "paper/_bookdown.yml")

        # Create results YAML file to paper folder.
        # This will setup up the PDF file format for just the
        # results of the paper using the bookdown package:
        yaml_input <- paste0('book_filename: ', paper_name, 'Results',
                             '\nrmd_subdir: [paper/figures/, paper/tables/]\n')
        write.table(yaml_input,
                    col.names = FALSE, row.names = FALSE,
                    qmethod = "double", quote = FALSE,
                    file = "paper/_bookdown2.yml")
    }

    # Create presentation folder:
    folder_presentation <- system.file("presentation", package = "easyresearch")

    if(!file.exists("presentation")){
        # Get names of folders to copy into presentation folder:
        folder_presentation_files = list.files(folder_presentation, full.names = TRUE)

        # Create presentation folder:
        dir.create("presentation", showWarnings = FALSE)

        # Copy folders to presentation folder:
        file.copy(folder_presentation_files, "presentation/", recursive = TRUE)
    }

    # Add the index.Rmd in the home director:
    file_index = system.file("index.Rmd", package = "easyresearch")

    if(!file.exists("index.Rmd")){
        # Copy folders to presentation folder:
        file.copy(file_index, "index.Rmd")
    }
}
