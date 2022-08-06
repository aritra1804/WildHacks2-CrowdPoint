import React from 'react'
import 'flowbite'
const Navbar = () => {
  return (
    
<nav class=" border-gray-200 px-2 sm:px-4 py-2.5 rounded bg-gray-900">
  <div class="container flex flex-wrap justify-between items-center mx-auto">
    <a href="https://flowbite.com/" class="flex items-center">
        {/* <img src={"https://flowbite.com/docs/images/logo.svg"} class="mr-3 h-6 sm:h-9" alt="Flowbite Logo"> */}
        <span class="self-center text-xl font-semibold whitespace-nowrap text-white">Crowd </span>
    </a>
    <button data-collapse-toggle="navbar-default" type="button" class="inline-flex items-center p-2 ml-3 text-sm rounded-lg md:hidden   focus:ring-2  text-gray-400 hover:bg-gray-700 focus:ring-gray-600" aria-controls="navbar-default" aria-expanded="false">
      <span class="sr-only">Open main menu</span>
      <svg class="w-6 h-6" aria-hidden="true" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd"></path></svg>
    </button>
    <div class="hidden w-full md:block md:w-auto" id="navbar-default">
      <ul class="flex flex-col p-4 mt-4  rounded-lg border  md:flex-row md:space-x-8 md:mt-0 md:text-sm md:font-medium md:border-0  bg-gray-800 md:bg-gray-900 border-gray-700">
        <li>
          <a href="#" class="block py-2 pr-4 pl-3 text-white bg-blue-700 rounded md:bg-transparent md:text-blue-700 md:p-0 dark:text-white" aria-current="page">Home</a>
        </li>
        <li>
          <a href="#" class="block py-2 pr-4 pl-3  rounded   md:border-0  md:p-0 text-gray-400 md:hover:text-white hover:bg-gray-700 hover:text-white md:hover:bg-transparent">Data</a>
        </li>
        <li>
          <a href="#" class="block py-2 pr-4 pl-3  rounded   md:border-0  md:p-0 text-gray-400 md:hover:text-white hover:bg-gray-700 hover:text-white md:hover:bg-transparent">Admin</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

  )
}

export default Navbar