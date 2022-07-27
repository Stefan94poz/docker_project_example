import type { NextPage } from 'next'
import { useEffect, useState } from 'react'

const Login: NextPage = () => {
  const [test, setTest] = useState<number>(0);

  useEffect(() => {
    setTest(1);
  },[])

  return (
    <h1>Stefa je #{test}</h1>
  )
}

export default Login
 