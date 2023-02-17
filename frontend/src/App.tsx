import { useState } from 'react'
import reactLogo from './assets/react.svg'
import './App.css'
import { rutas } from './config/routes'
import { Switch, Route } from 'wouter'

function App() {
    return (
        <div className='App'>
            <Switch>
                {rutas.map(({ path, component, name }) => (
                    <Route key={name} path={path} component={component} />
                ))}
            </Switch>
        </div>
    )
}

export default App
