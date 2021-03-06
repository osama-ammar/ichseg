% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CT_Skull_Strip_robust.R
\name{CT_Skull_Strip_robust}
\alias{CT_Skull_Strip_robust}
\alias{CT_Skull_Strip_register}
\alias{CT_Skull_Strip_smooth}
\title{Robust CT Skull Stripping}
\usage{
CT_Skull_Strip_robust(
  img,
  outfile = NULL,
  keepmask = TRUE,
  maskfile = NULL,
  retimg = TRUE,
  reorient = FALSE,
  int = "0.01",
  lthresh = 0,
  uthresh = 100,
  nvoxels = 5,
  remove.neck = TRUE,
  remover = c("remove_neck", "double_remove_neck"),
  smooth.factor = 2,
  recog = TRUE,
  verbose = TRUE,
  opts = NULL,
  mask_to_background = FALSE,
  template.file = system.file("scct_unsmooth_SS_0.01.nii.gz", package = "ichseg"),
  template.mask = system.file("scct_unsmooth_SS_0.01_Mask.nii.gz", package = "ichseg"),
  ...
)

CT_Skull_Strip_register(
  img,
  outfile = NULL,
  keepmask = TRUE,
  maskfile = NULL,
  retimg = TRUE,
  reorient = FALSE,
  lthresh = 0,
  uthresh = 100,
  remove.neck = TRUE,
  remover = c("remove_neck", "double_remove_neck"),
  verbose = TRUE,
  mask_to_background = FALSE,
  ...
)

CT_Skull_Strip_smooth(
  img,
  ...,
  smooth_before_threshold = TRUE,
  smooth.factor = 1,
  remove.neck = TRUE,
  remover = c("remove_neck", "double_remove_neck"),
  recog = FALSE,
  nvoxels = 0,
  add_1024 = FALSE
)
}
\arguments{
\item{img}{(character) File to be skull stripped or object of class
nifti}

\item{outfile}{(character) output filename}

\item{keepmask}{(logical) Should we keep the mask?}

\item{maskfile}{(character) Filename for mask
(if \code{keepmask = TRUE}).
If \code{NULL}, then will do \code{paste0(outfile, "_Mask")}.}

\item{retimg}{(logical) return image of class nifti}

\item{reorient}{(logical) If retimg, should file be
reoriented when read in?
Passed to \code{\link{readNIfTI}}.}

\item{int}{Fractional Intensity passed to
\code{\link{CT_Skull_Strip}} and
subsequently \code{\link{fslbet}}.}

\item{lthresh}{(default: 0) Lower value to threshold CT
\code{\link{fslthresh}}}

\item{uthresh}{(default: 100) Upper value to threshold CT
\code{\link{fslthresh}}}

\item{nvoxels}{Number of voxels to dilate/erode.
See \code{\link{dil_ero}}.
If \code{nvoxels = 0}, then no smoothing is done.}

\item{remove.neck}{Run \code{\link{remove_neck}} to register
the template to a
thresholded image to remove neck slices.}

\item{remover}{if \code{remove.neck = TRUE}, then which function
would you like to use to remove the neck}

\item{smooth.factor}{Smoothing factor for \code{\link{fslbet}}.
See \code{-w}
option in \code{fslbet.help()}.}

\item{recog}{Re-estimate the center of gravity (COG) and
skull strip.}

\item{verbose}{(logical) Should diagnostic output be printed?}

\item{opts}{Not used}

\item{mask_to_background}{When masking, should the values outside the
mask be set to 0 (default) or -1024 (when TRUE)}

\item{template.file}{Template to warp to original image
space, passed to
\code{\link{remove_neck}}}

\item{template.mask}{Mask of template to use as rough
brain mask, passed
to \code{\link{remove_neck}}}

\item{...}{additional arguments passed to
\code{\link{CT_Skull_Strip}} or
\code{\link{remove_neck}}.}

\item{smooth_before_threshold}{Should the image be smoothed before
thresholding?  This can be useful for bone-window scans.}

\item{add_1024}{Adding 1024 to the image *before* running the skull
stripping.  The values are subtracted after.  This has interplay with
\code{mask_to_background}}
}
\value{
Skull-stripped \code{nifti} object
}
\description{
Skull Stripping (using FSL's BET) a CT file
using \code{fslr}
functions and robustified by registration
}
\note{
This function first thresholds an image, runs a rigid
registration
(default in \code{\link{remove_neck}}) to drop any slices
below the transformed
skull stripped template to remove neck slices.  The neck-removed
image is
then skull stripped using defaults in \code{\link{CT_Skull_Strip}}.
 A new
center of gravity is estiamted using \code{\link{cog}}, then the
image is
skull stripped again using the new cog and the smoothness factor
(passed to \code{-w} argument in BET). After the skull stripped
mask is
created, the image is dilated and eroded using
\code{\link{dil_ero}} to
fill holes using a box kernel with the number of voxels
\code{nvoxels} in
all 3 directions.

\code{CT_Skull_Strip_register} removes the neck, registers the
image to the template, using a rigid-body transformation,
runs the skull stripper to get a mask, then transforms the mask
back to native space.
}
