---
fontfamily: tgtermes
title: "A Desktop Contact Printer for 16mm Motion Picture Film"
documentclass: article
author:
- name: Matthew McWilliams
  affiliation: sixteenmillimeter.com
  email: hi@mmcwilliams.com
abstract: |
    This paper introduces a design for a small-footprint contact printer for copying 16mm negatives to print stock.
    This free and open-source design can be manufactured using 3D printing and assembled using hobbyist electronic components, metric bolts and lengths of standardized aluminum extrusion.
    All of the design documentation, models for manufacturing and software are to be released freely and openly for public usage.
    It aims to fill a need for small-scale printing capability presented by artist-run film labs and individual filmmakers who are working with analog motion picture film for projection.
bibliography: sources.bib
csl: citation_style.csl
---

# Introduction

The contact printer is a tool for analog filmmaking that enables negative film to be printed to positive for projection and allows copies of existing films to be made.
In typical usage a camera-original negative film is placed in *contact* with an unexposed, undeveloped print stock and a light exposes the negative onto the print stock.

Intermittent-motion printers vs. continuous printers


# Motivations

The use of 16mm film and other small gauge formats has reached a new equilibrium where it is almost no longer used in mid-to-high budget productions aiming for distribution and many duplicate prints.
Big production companies still use analog movie film as a capture medium but a vast majority of them go to digital scans and real film projection is an after thought (if one at all).
Filmmakers that make prints for 16mm projection are a different population of people than 100, 50 or even 30 years ago--they make shorter films, they use more alternate techniques and they are working with fewer resources.
Creating a contact printer that is useful to and usable for those artists *now* means acknowledging that they work at a smaller scale and with different requirements.

Contact printers for working with shorter lengths of film and with a small footprint have been made previously but not for many years.
The Uhler Cine Printer provides a great example of a tool that solves the problem just presented and no action would be needed were it still being made today.
Its design was a product of the time it was created and therefore a modern approach is needed to make a contact printer that fulfills the same needs but, for example, won't be cast out of metal in a mass production run.
Still, it provides a guide as an example of a tool built for shorter films and with simple exposure controls.

# Design Philosophy

Designing a new contact printer at the same scale and feature complexity as the towering Bell & Howell Model C printer that was built to handle thousands of feet of film for printing features with intricate color and fade controls is not practical or within the engineering capabilities of the authors.
Creating one at the scale the Uhler Cine Printer that can be made using rapid prototyping techniques, however, will find a use to many artists.
A small, portable contact printer that can be quickly stored or even mounted vertically on a wall means that artists will not have to sacrifice floor or even table space to own and operate it.

This project adopts the RepRap model of using common components--"simple cheap and ubiquitous parts like screws and electric motors" [@reprap-philosophy]--and building the purpose-specific parts around them.
Aluminum extrusion, the same kind used to build 3D printers and CNC machines, provides a stable framing material that is readily available.
Cheap-but-reliably geared DC motors provide movement for the transport mechanism.

Modularity and open

Design as code gives the creator the benefits of working with code-managing tools and in producing the design in plaintext.

The source control software `git` [@git] 
Many of the illustrations and renderings in this paper were made by rolling back to earlier stages in the design process and using exactly what was represented in the code on specific dates or before certain changes were made.

Using a readable design format means that even if the software for rendering the printable models no longer exists or no longer works or for some reason cannot be executed, the features of the design can be preserved and recreated by reading the measurements it describes.
Take, for example, this snippet of OpenSCAD.

```cpp
difference () {
    cube([8, 8, 5], center = true);
    cylinder(r = 5 / 2, h = 5 + 1, center = true);
}
```

It describes an 8x8mm rectangle with a height of 5mm.
The `difference` operator means that the 5mm diameter cylinder is removed from it's center.



The ultimate goal of this project is to create a free and open design that is a platform that others can expand on to fulfill their production needs.
The goal is *not* to create a "product" and take on all of the expectations and economic considerations therein.

# SPECTRAL Residency at Filmwerkplaats

Motivation for this design was spurred on by the SPECTRAL project--Spatial, Performative & Expanded Cinematics – Transnational Research at Artist-run Labs[@spectral].

# The Contact Printer



## The Sprocketed Roller

Production of the sprocketed roller is made easier and more precise by the advent of SLA resin printing becoming more available and cheap in the recent years leading up to this development process.

SLA printing advances

Kinograph multi-format sprocketed roller.

## The Drive Motor

Speed

120 RPM 18 frame

Encoder motor

Near real time

Tests were run at 18fps, up to 24.

As low as 12fps.

PID control

Geared DC motor drawbacks : stopping has slack in system

24fps is the target because it theoretically could be used to write sound.



## The Lamp

The initial design for the lamp is to be simple and constant.
By reducing the number of variables on the light source of this printer

Initial tests of a three 5mm LED unit indicated that there needs to be more light to have exposure headroom.

Design with six 5mm LEDs was in the next iteration of the lamp that also allowed for an adjustable distance.
Assuming perfect light transmission in the new design, this would increase the exposure by a stop and 

## The Takeup Motors

A contact printer typically requires at least four reels, cores or spools to transport two strips of film.
Film must be driven from one side--the feed--to another side; the takeup.

The takeup motors for the picture and stock are based on a magnetic clutch design [@slp-clutch] inspired by the one used in The Shaffer Linear Processor [@slp].

The choice to direct drive the takeup is due to the fact that powerful geared DC motors are cheap and available.
Driving them separately, rather than using a belt, means that the speed can be controlled individually.
The speed of one takeup can be set to expect a 3 inch core but

## The Frame

Scalable.
The original prototype was made to support 100 foot daylight spools

By increasing the dimensions of the frame, the

## The Electronics

The central processing unit of this machine is an ESP32 development board.
Choosing an ESP32-based microcontroller allows for the use of the complete Arduino toolchain while maintaining the capability to add advanced features at later point in the design.
The microcontroller contains radios for Bluetooth Low Energy and Wifi-based connections, so a remote control application is possible.

## The Firmware

The Arduino platform uses a subset of C++

built using a modular object oriented programming style





# Assembly

## Printing the Components

PLA or PETG for most parts.
This may seem obvious but just to be clear: dark colored plastics reflect less light.
Printing parts in all black plastic best ensures that

## Assembling the Frame

Cut with miter box

Cut with drop saw


## Assembling the Electronics

# Operation



# Future Work

## Interfaces

## Sound

## Color Lamp Control

### References

---
refs: |
   ::: {#refs}
   :::
...