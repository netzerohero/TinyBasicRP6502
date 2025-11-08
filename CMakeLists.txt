cmake_minimum_required(VERSION 3.13)

project(MY-RP6502-PROJECT C ASM)

add_subdirectory(tools)

add_executable(tbasic)
rp6502_executable(tbasic
    DATA 0x200
    RESET 0x200
    ${CMAKE_CURRENT_SOURCE_DIR}/src/main.hlp
)
target_sources(tbasic PRIVATE
    src/main.s
    src/TinyBasic.s)
