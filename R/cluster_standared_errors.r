#' Function to cluster standard errors for linear models
#'
#' @export
#' @author Sean Brunson
#'
#' @examples
#' \dontrun{
#' model <- lm_cluster(data=data, formula=y ~ x, cluster="cluster_id")
#'
#' }

lm_cluster <- function(data, formula, cluster){
    # Fit linear model:
    model <- stats::lm(data = data, formula = formula)

    # Compute standard errors:
    vcov <- sandwich::vcovCL(x = model, cluster = data[cluster], type = "HC0")

    # Get summary of results:
    coeffs <- broom::tidy(lmtest::coeftest(model, vcov = vcov))
    stats <- broom::glance(model) %>%
        mutate(n = nrow(model$model))

    list(coeffs = coeffs,
         stats = stats)
}
