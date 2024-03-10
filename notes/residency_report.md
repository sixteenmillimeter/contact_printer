## Report on Residency at Filmwerkplaats

Matthew McWilliams

01/03/2024

------

### Dates 

18/02/2024 to 25/02/2024

### Artist Biography

Matt McWilliams is an artist and inventor working on free, open-source and open-hardware tools for analog filmmakers and photographers.
He works as a software developer in robotics research in the greater Boston area.
His website, [sixteenmillimeter.com](https://sixteenmillimeter.com), hosts various models for 3D printing as well as software and design documents for machines for making analog cinema that are all freely-available to use and modify under [The MIT License](https://opensource.org/license/mit).

### Project Description

The purpose of this project is to develop a free, open-source and open-hardware desktop contact printer for 16mm film to allow artists the ability to make prints of their 16mm films from negatives and other sources that would otherwise be cost and time prohibitive to do at a small scale.

Contact printers are an essential piece of film lab equipment that performs a simple but important service for filmmakers.
By taking two (or more) pieces of film--one of them developed and the other undeveloped--and sandwiching them together at the emulsion (the "contact") a light projected behind the developed film will impart a negative of the image on the undeveloped film.
In the simple case of having a stand of developed negative black and white 16mm film, one can pair it with a piece of undeveloped black and white 16mm print stock and produce a positive image that can be used for projection.

This project aims to leverage advances in 3D printing, cheap-but-reliable geared DC motors and open-platform microcontrollers to build a small, affordable and reproducible contact printer which can be used as-is or adapted and modified to fit the purposes of individuals and groups who are working with particular analog production techniques.

### Relevancy and Quality of the Project

Many artist-run film labs and individual filmmakers who work with small gauge analog film do not have access to large-footprint commercial machines and lack the space and maintenance resources to keep them.

Since information about commercially-developed equipment is guarded, expensive or even lost to time, starting a project from the principles of free, open-source software (FOSS) gives it a better chance to exist in the open where others can freely access it and improve upon its development without the risk of violating patents or copyright.

By designing a desktop-scale contact printer, in the spirit of the Uhler Cine Printer, artists who make short films can utilize it for making tests, work prints and even short release-quality prints without the need to work with large amounts of film at a time.
Filmmakers who work with hand-processed film in a small darkroom can process and then print on a machine not much larger than a laptop.

### Developed Activities

The work completed during the residency addressed practical limitations in the current design and established a list of improvements that will be made in the project.

Issues with the overall tension on the film as it advances across the drive gear and past the lamp head were resolved by adding thin spacers between the takeup and feed spindles and the magnetic clutches which allow them to tension the film without potentially snapping it.
Improving the tension of the film allows the film to be contact printed without the frame lines pulling up or down and improves image stability.

The optimal operating speed of the contact printing process was determined through a series of tests under different loads (no film, one film and two films) and utilizing performance assessment code written as part of the residency.
By testing the drive motor of the contact printer at different drive speeds, I was able to establish minimum and maximum operating speeds that can be predicted and monitored by the software.
18 frames per second was settled on as the speed most likely to be stabilized while transporting both print stock and negative with the "100RPM" motor that was selected for the drive sprocketed roller.
Since a single strip of film, likely the print stock, is capable of running at 24 or 25 fps, this means additional capabilities are possible in future developments; namely that the contact printer could be used with the optical soundtrack recorder being developed in parallel by Hrvoje Spudić.
The 18 frame sprocketed roller, driven stably at 60RPM with two strips of film, can also be run at or above 24fps to record sound to stock in real-time.

Tests with Kodak 3302 black and white print stock and 3383 color print stock established a baseline for exposure that will be used to improve the lamp design.
Currently employing three standard 5mm (6000K) white LED bulbs powered with 5V DC and with 330 Ohm resistance each, we know that a standard 216 diffusion gel and a .6 ND filter will produce a proper gray card density from a LAD test negative on black and white print stock (Kodak 3302).
Similarly, we were able to approximate the exposure and filters required to print from color negative onto color print stock although further testing and development will be needed.

Immediate next tasks are to address the lamp design, user interface issues and motor speed stability.

The lamp should be expanded from a 3 LED to 6 LED design for increased exposure headroom and from solid color modules to RGB-controllable ones.
This will improve color printing and remove the need for as many physical color filters which ultimately reduce the amount of light needed to make accurate exposures on color print stock.

Since the behavior of the contact printer can only currently be altered with code changes, a UI beyond a start/stop button must be implemented.
Though the aims of this design are simple, contact printing analog film has many variables and being able to adjust for them is one of the main advantages of using DIY projects such as these.
Exposing functionality to artists,

### Artist's Feedback

The amount of knowledge, expertise, capacity for experimentation and encouragement to work was unique and indispensable.
The only thing I would request or suggest is for more time at the residency, though the limitation is entirely with my schedule.
Having the ability to change code, strike print tests and process them without leaving the darkroom made progress possible at a rate previously not available to the project.
Without the support and resources provided by this residency, months or years would have been spent trying to discover what was during those seven days.

### Images

-----

![](../img/EN_FundedbytheEU_RGB_POS.png)
