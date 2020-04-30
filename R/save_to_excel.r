#' Removes old files from result's folder
#'
#' Get all file names in result's folder, put in dataframe, and remove old ones
#' if name and date are old
#' @param title Title of old file
#' @export
#' @author Sean Brunson

remove_from_folder <- function(title){
    # Get current date:
    current_date <- Sys.Date()

    # Get all file names in result's folder, put in dataframe, and remove old ones
    # if name and date are old:
    all_files <- list.files("results/") %>%
        enframe(name = NULL) %>%
        separate(value, c("name", "date"), sep = " \\(") %>%
        mutate(date = str_remove_all(date, "\\).xlsx")) %>%
        filter(name == title,
               date != current_date)

    # Make files back to original form in order to delete:
    files_to_delete <- all_files %>%
        mutate(file_name = paste0("results/", name, " ", "(", date, ").xlsx")) %>%
        select(file_name) %>%
        .[[1]]

    # Print message:
    print(paste0("Deleting ", files_to_delete))

    # Delete files in all_files:
    unlink(files_to_delete)
}

#' Saves data to Excel file
#'
#' Takes results and creates and saves to Excel file
#' @inheritParams openxlsx::writeData
#' @param results Results
#' @param title Title of new Excel file
#' @param worksheet_name Name of worksheet
#' @export
#' @author Sean Brunson

save_to_excel <- function(results, title, worksheet_name = NULL){
    # Get current date and create file name:
    current_date <- Sys.Date()
    file_name <- paste0("results/", title, " ", "(", current_date, ").xlsx")

    # Create Excel workbook and add worksheet:
    wb <- openxlsx::createWorkbook(file_name)
    if(is.null(worksheet_name)){
        openxlsx::addWorksheet(wb, title)
    } else{
        openxlsx::addWorksheet(wb, worksheet_name)
    }

    # Write and save data to Excel:
    if(is.null(worksheet_name)){
        openxlsx::writeData(wb, title, results, rowNames = FALSE)
    } else{
        openxlsx::writeData(wb, worksheet_name, results, rowNames = FALSE)
    }

    openxlsx::saveWorkbook(wb, file_name, overwrite = TRUE)

    # Print message:
    print(paste0("Saved to: ", file_name))

    # Delete old files:
    remove_from_folder(title)
}

#' Adds data to Excel file
#'
#' Takes results and adds it to existing Excel file. Only used after
#' \code{\link{save_to_excel}}
#' @inheritParams openxlsx::writeData
#' @param results Results
#' @param title Title of new Excel file
#' @param worksheet_name Name of worksheet
#' @export
#' @author Sean Brunson

add_additional_worksheet <- function(results, title, worksheet_name){
    # Get current date and create file name:
    current_date <- Sys.Date()
    file_name <- paste0("results/", title, " ", "(", current_date, ").xlsx")

    # Create Excel workbook and add worksheet:
    wb <- openxlsx::loadWorkbook(file_name)
    openxlsx::addWorksheet(wb, worksheet_name)

    # Write and save data to Excel:
    openxlsx::writeData(wb, worksheet_name, results, rowNames = FALSE)
    openxlsx::saveWorkbook(wb, file_name, overwrite = TRUE)

    # Print message:
    print(paste0("Added worksheet to: ", file_name))
}
